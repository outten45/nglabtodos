# nglabtodos

A command line tool to notify you have pending todos from a gitlab instance. The
notification comes in the form of posting to a mattermost instance (could
probably work with slack too).

# Setup

You need the following environment variables set:

* `GLAB_HOST` - The schema and host (for example https://gitlab.example.com)
* `GLAB_APIPATH` - The URI of the API (for example /api/v3/)
* `GLAB_TOKEN` - Your access token setup in GLAB_LAB
* `MM_WEBHOOK` - Webhook in mattermost to post the message to

# Compile

To compile from the command line you will need the [nim
compiler](https://nim-lang.org/install.html) installed. Once that is installed,
you can use the following command to create a `nglabtodos` binary.

    > nim c -d:ssl nglabtodos.nim

