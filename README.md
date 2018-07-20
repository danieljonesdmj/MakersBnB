# MakersBnB

## Summary

Week 6 Makers Academy group project to develop an Airbnb clone, called MakersBNB. <br>
[Initial specification here.](https://github.com/makersacademy/course/blob/master/makersbnb/specification_and_mockups.md)
___

## Credits

Developed over the course of 4 days by Layth Al-Qattan, Daniel Jones, Elishka Flint and Ben Smith-Gordon.

Reflections on process and learnings from our first week of group-work can be found [here](https://hackmd.io/j1BJktk9R-O9vQq5XxgC_w).

___

## Objectives

Agreed in first planning meeting:
* Learn how to develop a product in a team
* Learn how to delegate responsibilities amongst ourselves
* Deliver a product **together** - work as a team even if it takes longer than one person delivering features on their own
* Communicate well - ongoing updates, clear written communication (eg. function names, commits, branch names, code review comments)
* Give each other constructive feedback throughout the process

___

## State of Completion

### Implemented Functionality

#### Front-end
* Sign up, log in (with authentication), password encryption
* Summary of listings, split between listings belonging to the current user and other listings
* Option to request a listing, which owner can then approve within their session

#### Back-end
* Databases to hold users, listings, requests and dates (with a join table for the many-to-many relationship between listings and dates)
* Classes to wrap data extracted from each database
* Rakefile to automate database tasks locally (set up, reset, teardown)

### What we would do next
* Extract database connection into a separate class
* Refactor tests where code has become repetitive (particularly Capybara feature tests)
* Fix some small bugs in our rakefiles which have required manual fixes in the command line
* Use flash functionality to guard against incorrect user inputs (eg. bad log-in)
* Implement next user stories
___

## User Stories:

#### Implemented in first sprint:

```
As a User,
So I can list my home,
I want to be able to sign up.

As a User,
So that I can list a new space,
I want to list a space with a name.

As a User,
So that I can rent a space,
I want to be able to see the available space with a name.

As a User,
So that I can rent a space,
I want to be able to request a space.

As a User,
So that I can rent out my space,
I want to be able to approve the user's request.
```

#### Implemented in second sprint:

```
As a User,
So that I can rent out my space at a convenient time,
I want to list my space with a range of available dates.

As a User,
So that I can rent a space,
I want to be able to see the available space with a name, price, description and available date.
```

#### User stories we would implement in another sprint:

```
As a User,
So that I can rent a space,
I want to be able to request the space on a specific date.

As a Homeowner,
So that I only rent my space to one person,
I want my space to be marked as unavailable on a date when it has already been rented out.
```
___

## Technical

### Tech/Frameworks Used

Ruby, Sinatra, HTML, CSS, RSpec, Rubocop, Capybara, Rackup, PostgreSQL, Rake

### Launching the Application

```
$ git clone https://github.com/elishkaflint/chitter-challenge.git
$ bundle
$ rackup config.ru (Answer 'y' to command line prompts)
```
____
