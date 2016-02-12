# Process Guide

## Submitting Changes

0. Ensure tests are passing
1. Create pull request
2. Get pull request reviewed (posting in Core, PM'ing people, in-person, etc.)
3. Do you need to deploy?
  * If yes, see deploy process
  * If no, merge and monitor the next Jenkins build

### Do I need to deploy?

* Does your deploy involve any production files (e.g. most things in `app/`, `lib/`, `config/`)? If so, then yes
* Does your deploy only involve test files (e.g. things in `test/`, `script/parallel_test`, `config/environments/test`)? If so, then no, you can just merge to master
* Does your deploy only involve dev files (e.g. most things in `lib/tasks`, `script/reset_*`, `config/environments/development`)? If so, then no, you can just merge to master

### Where do I need to deploy?

* We have a few different deploy roles. The major breakdown is `app`, `qless_worker`, `db`, and `tools`
* Does your change only involve Rails controllers/routes, javascript, and css? If so, you only need to deploy to `app`
* Does your change involve jobs, Rails models, or other back-end changes? If so, you should deploy to `qless_worker`
* Does your change involve a Rails migration? If so, you should deploy to `db`, and you should make sure to migrate the database
* Does your change only involve utility scripts for debugging a customer issue? You might be able to get away with deploying only to `tools`
* When in doubt ask someone for advice or just deploy to everything

### About the deploy roles

* Some deploy roles are safer to deploy to than others. If you have a critical deploy that needs to go out and needs to break our standard
deploy process then here are the things you should consider about each type of host.
* In general, `tools` is the lowest priorty. It hosts some of our internal monitoring servers and may have some utility scripts running on it,
but for the most part it's there for us to experiment with. You can usually deploy here when you want and no one will mind.
* `app` is important to the business, however it usually has a quicker feedback cycle than workers and we have less `app` hosts than we do `qless_worker`.
That is, we can quickly notice that something is wrong and can fix it with a minimal window of impact. Because of this it is safer to deploy to.
Complex changes should still be thoroughly reviewed, and things that affect the asset pipeline should be reproduced locally first for verification if the change is large. 
Verifying changes to `app` usually involves manual testing.
* `qless_worker` is critical. It runs on 100+ hosts and breakages can have major set backs for the business. It's important to follow our standard deploy
process whenever possible to reduce impact to these. Sometimes it can take awhile for issues to arise due to the nature of our jobs, so it's important to
deploy to these early so we have the work day to monitor the change. Verifying changes to `qless_worker` usually involves monitoring in Splunk and manual testing.
One approach to reduce impact and test changes is to either deploy to `tools` first or to deploy to a small number of workers.
You should also verify big changes in staging if possible.
* `db` is also critical as it is central to pretty much all of our processing for the other servers. Our standard deploy process should be closely followed because
of the potential impact on this host. Changes to `db` usually only involve migrations, which have a quicker feedback cycle than workers (you can go onto tools and test
changes in the Rails console), but a missing table or column can cause a lot of errors if not done properly. Do remember to deploy with migrations when you need to
run a migration.

## Standard deployment process

1. Get your pull request reviewed and approved
2. Post the `add deploy DESCRIPTION_OF_PR LINK_TO_PR` message in Core in HipChat
3. When it is your turn to deploy, post the `start deploy` message in HipChat
4. Merge your pull request
5. Run your deploy
6. Verify that your deploy worked
7. Post the `verify deploy` message in HipChat

### Running your deploy

TODO

### Debugging your deploy

TODO
