
DROP TABLE IF EXISTS tweets;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS likes;
DROP TABLE IF EXISTS hashtag;
DROP TABLE IF EXISTS likes;
DROP TABLE IF EXISTS follows;
DROP TABLE IF EXISTS hashtag_tweets;


CREATE TABLE users (
                       id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
                       name VARCHAR (30) ,
                       email VARCHAR (40) NOT NULL ,
                       address TEXT,
                       postal_code TEXT,
                       city TEXT NOT NULL ,
                       country TEXT NOT NULL
);

CREATE TABLE tweets (
                       id INTEGER PRIMARY KEY AUTOINCREMENT,
                       content TEXT NOT NULL,
                       created_at TEXT DEFAULT CURRENT_TIMESTAMP,
                       user_id INTEGER,
                       foreign key (user_id) references users(id)
);

CREATE TABLE hashtag (
                       name TEXT PRIMARY KEY
);

CREATE TABLE hashtag_tweets (
                       tweet_id INTEGER,
                       hashtag_name TEXT,
                       PRIMARY KEY (tweet_id, hashtag_name),
                       foreign key (tweet_id) references tweets(id),
                       foreign key (hashtag_name) references hashtag(name)
);

CREATE TABLE likes (
                       user_id INTEGER,
                       tweet_id INTEGER NOT NULL,
                       created_at DATE DEFAULT (datetime('now', 'localtime')),
                       PRIMARY KEY (user_id, tweet_id),
                       foreign key (user_id) references users(id),
                       foreign key (tweet_id) references tweets(id)
);

CREATE TABLE follows (
                       followed_user_id INTEGER,
                       follow_user_id INTEGER,
                       PRIMARY KEY (followed_user_id, follow_user_id),
                       foreign key (followed_user_id) references users (id),
                       foreign key (follow_user_id) references users (id)
);

-- insert users

INSERT INTO
    users (name, email, address, postal_code, city, country)
VALUES ('John Smith', 'john.smith@example.com', '123 Main Street', '12345', 'New York', 'United States' ),
       ('Emma Johnson', 'emma.johnson@example.com', '456 Oak Avenue', '67890', 'Los Angeles', 'United States' ),
       ('Mohammed Ahmed', 'mohammed.ahmed@example.com', '789 Elm Street', '54321', 'London', 'United Kingdom' );

-- insert tweets

INSERT INTO
    tweets (content, user_id )
VALUES ('Just witnessed an epic tennis match! The intensity, skill, and rivalry on the court were absolutely thrilling. #TennisLove', 2),
       ('Incredible display of athleticism in the tennis match today. The players agility and precision shots left us in awe. #TennisAction', 1),
       ('What a comeback in the tennis match! The player fought back from being two sets down to win the match in a nail-biting tiebreaker. #NeverGiveUp', 3),
       ('Wow! The red carpet was buzzing with glamour and excitement at the Hollywood ceremony tonight. A star-studded affair filled with stunning fashion, dazzling smiles, and unforgettable moments. #HollywoodGlam', 3),
       ('Caught up in the glitz and glamour at the Hollywood ceremony tonight! The red carpet was a sight to behold, with celebrities shining in their stunning outfits. Excitement fills the air as we await the big winners of the night. #AwardsSeason', 2),
       ('Wow, what a mesmerizing Hollywood ceremony! The red carpet was adorned with stunning fashion, and the stars shone brightly as they graced the stage. It was a night of glitz, glamour, and unforgettable moments. #CelebrityStyle', 1),
       ('Just saw an incredible film that had me on the edge of my seat the entire time! The plot twists, the stunning visuals, and the outstanding performances made it a must-watch. #MovieMagic', 1),
       ('Caught a classic film on TV last night, and it reminded me why I love cinema. The captivating storytelling, timeless themes, and brilliant acting left a lasting impact. #MovieNight', 3),
       ('Film has the power to transport us to different worlds, evoke emotions, and spark conversations. Whether its a comedy, drama, or action-packed adventure, its a medium that connects us all. #FilmLover', 2);

-- insert hashtag

INSERT INTO
    hashtag (name)
VALUES ('#TennisLove'),
       ('#TennisAction'),
       ('#NeverGiveUp'),
       ('#HollywoodGlam'),
       ('#AwardsSeason'),
       ('#CelebrityStyle'),
       ('#MovieMagic'),
       ('#MovieNight'),
       ('#FilmLover');


-- insert hashtag_tweet

INSERT INTO
    hashtag_tweets (tweet_id, hashtag_name)
VALUES (1, '#TennisLove'),
       (2, '#TennisAction'),
       (3, '#NeverGiveUp'),
       (4, '#HollywoodGlam'),
       (5, '#AwardsSeason'),
       (6, '#CelebrityStyle'),
       (7, '#MovieMagic'),
       (8, '#MovieNight'),
       (9, '#FilmLover');

INSERT INTO
    likes (user_id, tweet_id)
VALUES (1,1),
       (1,3),
       (1,8),
       (2, 8),
       (2,3),
       (3,7);

SELECT * FROM likes;

