#!/bin/bash

# Copyright 2019 The Bazel Authors. All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -eu

# Assert that the bundle itself is signed.
assert_is_codesigned "$BUNDLE_ROOT"

# If it has any frameworks, assert that they are signed as well.
if [[ -d "$CONTENT_ROOT/Frameworks" ]]; then
  for fmwk in \
      $(find "$CONTENT_ROOT/Frameworks" -type d -maxdepth 1 -mindepth 1); do
    assert_is_codesigned "$fmwk"
  done

  # Assert that the frameworks have not been resigned.
  assert_frameworks_not_resigned_given_output "$BUNDLE_ROOT"
fi
