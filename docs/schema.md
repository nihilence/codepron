# Schema Information

## previews
column name | data type | details
------------|-----------|-----------------------
id          | integer   | not null, primary key
author_id   | integer   | indexed
title       | string    | not null
description | text      |
html        | string    |
css         | string    |
js          | string    |
combined    | string    |

## users
column name | data type | details
------------|-----------|-----------------------
id          | integer   | not null, primary key
email    | string    | not null, indexed, unique
pw_digest   | string    | not null
sess_token  | string    | not null, unique

## comments
column name | data type | details
------------|-----------|-----------------------
id          | integer   | not null, primary key
author_id   | integer   | not null, indexed
preview_id  | integer   | not null
body        | text      | not null

## follows
column name | data type | details
------------|-----------|-----------------------
id          | integer   | not null, primary key
followed_id | integer   | not null
follower_id | integer   | not null
