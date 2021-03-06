import requests
import json
import os

headers = {"Accept": "application/vnd.travis-ci.2+json"}
url = "https://api.travis-ci.com/repos/" + os.environ["TRAVIS_REPO_SLUG"] + "/builds/" + os.environ["TRAVIS_BUILD_ID"]

TRAVIS_JOB_NUMBER = int(os.environ["TRAVIS_JOB_NUMBER"][len(os.environ["TRAVIS_BUILD_NUMBER"]) + 1:])
try:
    status = requests.get(url, headers=headers).json()
except:
    status = None

if status:
    for job in status['jobs'][:TRAVIS_JOB_NUMBER]:
        if job["config"]["os"] == os.environ["TRAVIS_OS_NAME"] and not job["allow_failure"] and job["state"] in ['failed', 'errored']:
             raise Exception("A previous job failed !")
