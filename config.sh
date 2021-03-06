## Copyright [2017-2018] UMR MISTEA INRA, UMR LEPSE INRA,                ##
##                       UMR AGAP CIRAD, EPI Virtual Plants Inria        ##
##                                                                       ##
## This file is part of the StatisKit project. More information can be   ##
## found at                                                              ##
##                                                                       ##
##     http://autowig.rtfd.io                                            ##
##                                                                       ##
## The Apache Software Foundation (ASF) licenses this file to you under  ##
## the Apache License, Version 2.0 (the "License"); you may not use this ##
## file except in compliance with the License. You should have received  ##
## a copy of the Apache License, Version 2.0 along with this file; see   ##
## the file LICENSE. If not, you may obtain a copy of the License at     ##
##                                                                       ##
##     http://www.apache.org/licenses/LICENSE-2.0                        ##
##                                                                       ##
## Unless required by applicable law or agreed to in writing, software   ##
## distributed under the License is distributed on an "AS IS" BASIS,     ##
## WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or       ##
## mplied. See the License for the specific language governing           ##
## permissions and limitations under the License.                        ##


export ANACONDA_FORCE="true"

if [[ "$ANACONDA_LABEL" = "release" ]]; then
    if [[ "$TRAVIS_BRANCH" = "master" || ! "$TRAVIS_TAG" = "latest" ]]; then
        if [[ "$OLD_BUILD_STRING" = "" ]]; then
            export OLD_BUILD_STRING="false"
        fi
        export ANACONDA_LABEL_ARG=$TRAVIS_OS_NAME-$ARCH"_release"
    else
        if [[ "$OLD_BUILD_STRING" = "" ]]; then
            export OLD_BUILD_STRING="true"
        fi
        export ANACONDA_LABEL_ARG="unstable"
    fi
else
    if [[ "$OLD_BUILD_STRING" = "" ]]; then
        export OLD_BUILD_STRING="false"
    fi
    export ANACONDA_LABEL_ARG=$ANACONDA_LABEL
fi

if [[ "$ANACONDA_OWNER" = "openalea" && ! "$ANACONDA_LABEL" = "release" && ! "$ANACONDA_LABEL" = "unstable" ]]; then
    echo "Variable ANACONDA_LABEL set to '"$ANACONDA_LABEL"' instead of 'release' or 'unstable'"
    exit 1
fi

if [[ ! "$ANACONDA_OWNER" = "openalea" ]]; then
    conda config --add channels openalea
    if [[ ! "$ANACONDA_LABEL" = "release" ]]; then
        conda config --add channels openalea/label/unstable
    fi
fi

if [[ ! "$ANACONDA_OWNER" = "" ]]; then
    conda config --add channels $ANACONDA_OWNER
    if [[ ! "$ANACONDA_LABEL_ARG" = "main" ]]; then
        conda config --add channels $ANACONDA_OWNER/label/$ANACONDA_LABEL_ARG
    fi
fi
