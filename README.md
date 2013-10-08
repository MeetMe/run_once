run_once Cookbook
=================
Manage actions in cookbooks that should only run once in both chef-solo and
chef-client.

Usage
-----
To use in your cookbooks, simply include the run_once recipe and use the
`RunOnce.has_run?` and `RunOnce.ran` methods.

    include_recipe 'run_once'

    ruby_bock 'do-something' do
      block do
        # Your code
        RunOnce.ran(node, :my_cookbook, :do_something)
      end
      not_if {RunOnce.has_run?(node, :my_cookbook, :do_something)}
    end

Attributes
----------
run_once will determine which is the best way to store the run_once attributes
based upon which way the recipe is run. If it is used by a recipe run by chef-solo,
the attributes for run_once are kept in `/var/chef/cache/run_once.json`.  When used
by a recipe run by chef-client, the node will have an tree of attributes under
`[:run_once]` in the format `[:run_once][COOKBOOK][FLAG]`.

License and Author
------------------
Author:: Gavin M. Roy (gmr@meetme.com) Copyright:: 2013, MeetMe, Inc

Copyright (c) 2013, MeetMe, Inc.
All rights reserved.

Redistribution and use in source and binary forms, with or without modification,
are permitted provided that the following conditions are met:

 * Redistributions of source code must retain the above copyright notice, this
   list of conditions and the following disclaimer.
 * Redistributions in binary form must reproduce the above copyright notice,
   this list of conditions and the following disclaimer in the documentation
   and/or other materials provided with the distribution.
 * Neither the name of the MeetMe, Inc. nor the names of its
   contributors may be used to endorse or promote products derived from this
   software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.