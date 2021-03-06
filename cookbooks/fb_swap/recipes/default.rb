#
# Cookbook Name:: fb_swap
# Recipe:: default
#
# vim: syntax=ruby:expandtab:shiftwidth=2:softtabstop=2:tabstop=2
#
# Copyright (c) 2016-present, Facebook, Inc.
# All rights reserved.
#
# This source code is licensed under the BSD-style license found in the
# LICENSE file in the root directory of this source tree. An additional grant
# of patent rights can be found in the PATENTS file in the same directory.
#

# TODO(yangxia): Remove fb_swap::old and just copy fb_swap::new into this
#                file once we're sure the new recipe doesn't cause issues.
if node.in_shard?(99)
  include_recipe 'fb_swap::new'
else
  include_recipe 'fb_swap::old'
end
