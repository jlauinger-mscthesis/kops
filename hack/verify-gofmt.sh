#!/bin/bash

# Copyright 2016 The Kubernetes Authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

. $(dirname "${BASH_SOURCE}")/common.sh

GOFMT="gofmt -s -w"

bad_files=$(cat ${KUBE_ROOT}/hack/.packages | grep -v "^k8s.io/kops$" | sed -e s-^k8s.io/kops/-- | xargs -I {} $GOFMT -l {})
if [[ -n "${bad_files}" ]]; then
  echo "!!! '$GOFMT' needs to be run on the following files: "
  echo "${bad_files}"
  echo "!!! Please run: make gofmt"
  exit 1
fi
