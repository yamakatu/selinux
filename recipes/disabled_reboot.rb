#
# Author:: Katsushi Yamashita (<yamakatun@hotmail.co.jp>)
# Cookbook Name:: selinux
# Recipe:: disabled_reboot
#
# Copyright 2012, Opscode, Inc.
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
#

template "/etc/selinux/config" do
  source "sysconfig/selinux.erb"
  variables(
    :selinux => "disabled",
    :selinuxtype => "targeted"
  )
end

execute "reboot to make selinux desabled" do
  not_if "getenforce | grep -qxi 'disabled'"
  command "reboot"
  action :run
end
