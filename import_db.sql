CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname VARCHAR(255),
  lname VARCHAR(255)
);

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title VARCHAR(255),
  body TEXT,
  user_id INTEGER NOT NULL,

  FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE question_followers (
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  user_id INTEGER NOT NULL,

  FOREIGN KEY(question_id) REFERENCES questions(id),
  FOREIGN KEY(user_id) REFERENCES users(id)
);

CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  parent_id INTEGER,
  user_id INTEGER NOT NULL,
  body TEXT,

  FOREIGN KEY(question_id) REFERENCES questions(id),
  FOREIGN KEY(user_id) REFERENCES users(id)
);

CREATE TABLE question_likes (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,

  FOREIGN KEY(question_id) REFERENCES questions(id),
  FOREIGN KEY(user_id) REFERENCES users(id)
);

INSERT INTO
  users (fname, lname)
VALUES
  ('Nathan','Seither'),
  ('Nico', 'Lui');

INSERT INTO
  questions (title, body, user_id)
VALUES
  ('Who likes SQL?','Certainly not me!', '1'),
  ('What is with this indenting?', 'It sucks!', '2'),
  ('Do you like cheese?', 'Yeaaaaa', '1');

INSERT INTO
  question_followers (question_id, user_id)
VALUES
  (1, 2),
  (2, 1);

INSERT INTO
  replies (question_id, parent_id, user_id, body)
VALUES
  (1, NULL, 2, 'Me neither!'),
  (2, NULL, 1, 'TOTALLY!'),
  (1, 1, 1, 'STILL HATE IT!');

INSERT INTO
  question_likes (user_id, question_id)
VALUES
  (2,1),
  (1,1),
  (1,2);
