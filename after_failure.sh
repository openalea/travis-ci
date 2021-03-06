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

set -ev

if [[ ! "$ANACONDA_LOGIN" = "" ]]; then
    source before_deploy.sh
    if [[ ! "$CONDA_RECIPE" = "" && -d $CONDA_PREFIX/conda-bld/broken ]]; then
        for filename in $CONDA_PREFIX/conda-bld/broken/*.tar.bz2; do
            anaconda upload $filename -u $ANACONDA_OWNER $ANACONDA_FORCE --label broken
        done
    elif [[ ! "$JYPTER_NOTEBOOK" = "" ]]; then
        anaconda upload ../$JYPTER_NOTEBOOK -u $ANACONDA_OWNER --label $TRAVIS_OS_NAME-broken --force
    fi
    source after_deploy.sh
fi

set +ve
