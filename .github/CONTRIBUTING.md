# Contribution guidelines

We're happy to accept 3rd-party contributions. Please make sure you read this document before you do any work though,
as we have some expectations related to the content and quality of change sets.

## What you should know about this application

This project is a template Spring Boot application. It aims to speed up the creation of new Spring APIs in HMCTS
projects, by serving as the initial setup of each API.

## Before contributing

Any ideas on the user journeys and general service experience you may have **should be first consulted
with us by submitting a new issue** to this repository. Ideas are always welcome, but if something is divergent or unrelated
to what we're trying to achieve we won't be able to accept it. Please keep this in mind as we don't want to waste anybody's time.

In the interest of creating a friendly collaboration environment, please read and adhere to an open source contributor's
[code of conduct](http://contributor-covenant.org/version/1/4/).

## Making a contribution

After your idea has been accepted you can implement it. We don't allow direct changes to the codebase from the public,
they have to go through a review first.

Here's what you should do:
1. [fork](https://help.github.com/articles/fork-a-repo/) this repository and clone it to your machine,
2. create a new branch for your change:
 * use the latest *master* to branch from,
3. implement the change in your branch:
 * if the change is non-trivial it's a good practice to split it into several logically independent units and deliver
   each one as a separate commit,
 * make sure the commit messages use proper language and accurately describe commit's content, e.g. *"Unify postcode lookup elements spacing"*.
   More information on good commit messages can be found [here](http://chris.beams.io/posts/git-commit/),
4. test if your feature works as expected and does not break any existing features, this may include implementing additional automated tests or amending existing ones,
5. push the change to your GitHub fork,
6. submit a [pull request](https://help.github.com/articles/creating-a-pull-request-from-a-fork/) to our repository:
 * ensure that the pull request and related GitHub issue reference each other.

At this point the pull request will wait for someone from our team to review. It may be accepted straight away,
or we may ask you to make some additional amendments before incorporating it into the main branch.
