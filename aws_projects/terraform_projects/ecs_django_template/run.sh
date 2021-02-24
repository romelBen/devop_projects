#!/bin/bash
#run.sh

BASEDIR=$(dirname "$0")
SCRIPT_NAME=$(basename "$0")

PYTHON_VERSION="3.7.9"

usage () {
    echo
    echo "$SCRIPT_NAME - program used for running all the things"
    echo
    echo "valid targets:"
    echo
    echo "  build          Builds docker container"
    echo "  start          Starts the server"
    echo "  stop           Stops the server"
    echo "  submit         Archives your code and pushes your Docker image"
    echo "  tests          Runs tests"
    echo
}

prompt_yes_no () {
    local prompt_msg=$1

    while true; do
        read -p "$prompt_msg [y/N] " yn
        case $yn in
            [Yy]* )
                break
                ;;
            [Nn]* )
                exit;;
            * )
                exit;;
        esac
    done
}

##
## setup_candidate_marker:
##   Helper for setting up a marker used to label files specific to
##   interviewer.
##
setup_candidate_marker () {
    export BEVY_INFRA_CANDIDATE_MARKER="$(echo $CANDIDATE_LAST_NAME | tr '[:lower:]' '[:upper:]')_$(echo $CANDIDATE_FIRST_NAME | tr '[:lower:]' '[:upper:]')"
    echo $BEVY_INFRA_CANDIDATE_MARKER
}

do_build () {
    docker-compose build
}

##
## do_backup: Starts the application server
##
do_start () {
    echo "Starting server..."
    docker-compose up -d
}

##
## do_stop: Stops the application server
##
do_stop () {
    echo "Stopping server..."
    docker-compose down
}

##
## do_submit_assignment:
##    Creates a tarball of your working directory for
##    submission and pushes your docker image to a repository (this
##    exercise is left for the interviewer to complete)
##
do_submit_assignment () {
    echo "Starting assignment submission process..."

    prompt_yes_no "Are you ready to submit the assignment?"

    [[ -e ".env" ]] || { echo "missing .env file" && exit 1; }

    set -a && source ./.env && set +a

    setup_candidate_marker

    # Easy submission
    local filename="${BEVY_INFRA_CANDIDATE_MARKER}_bevy-infra-project-submission.tar.gz"
    ls -1A | xargs tar zcvf $filename --exclude-from .gitignore

    echo
    echo "Tarball created!"
    echo "Please submit this file:  $filename"
    echo
    echo "Done"
}

##
## do_tests: Runs the unit tests for program
##
do_tests () {
    echo "Running tests..."
    python manage.py test
}

main () {
    local target=$1

    case $target in
        build)
            do_build
            ;;
        start)
            do_start
            ;;
        stop)
            do_stop
            ;;
        submit)
            do_submit_assignment
            ;;
        tests)
            do_tests
            ;;
        *)
            usage
            exit 1
            ;;
    esac
}

main $1