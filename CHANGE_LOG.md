### Openapply CHANGE LOG

* **v1.0.2** - compatible with 1.0.x - 2020-05-18
  - improve auth token generation

* **v1.0.1** - compatible with 1.0.x - 2020-05-18
  - update dependencies

* **v1.0.0** - compatible with 1.0.x - 2020-05-14
  - update path to use OpenApply API v3
  - oauth authentification
  - add arguments in addition to environment variables

* **v0.4.2** - compatible with 0.4.x - 2020-03-03
  - update dependencies

* **v0.4.1** - compatible with 0.4.x - 2018-06-19
  - force all openapply interactions to use https

* **v0.4.0** - compatible with 0.3.x - 2018-06-08
  - add put ability for student id and status

* **v0.3.3** - compatible with 0.3.x - 2018-04-20
  - add more exceptions to catch misconfigs and alert coder

* **v0.3.2** - compatible with 0.3.x - 2018-04-11
  - add another break condition (prevent nil)

* **v0.3.1** - compatible with 0.3.x - 2018-04-10
  - protect against nil error no when meta info returned from OA
  - add error / exception when ENV doesn't load properly
  - remove unused gems (scp and ssh)
  - add example / demo usage code

* **v0.3.0** - compatible with 0.3.x - 2018-01-31
  - NOT compatible with 0.2.x
  - migrate to new documentation style
  - refactor to use options - simplify and improve usage
  - refactor to be more modular (usage will change)

* **v0.2.10** - compatible with 0.2.x - 2018-01-04
  - updated rake and webmock gems in deve
  - removed roo - not needed

* **v0.2.9** - compatible with 0.2.x - 2017-12-13 *(https://github.com/straydogstudio/axlsx_rails/issues/77)*
    - separated convert (& its dependencies) into separate modules that can be loaded on need in the next version (0.3.x)
    - hash to array now handles both student_details and student_summaries (this also allows conversion then to csv)

* **v0.2.8** - compatible with 0.2.x - 2017-12-11 *(https://github.com/randym/axlsx/issues/234)*
  - axlsx - passes tests - but won't properly install inside another project (even using gem install ./openapply-0.2.7) - will look for a solution

* **v0.2.7** - compatible with 0.2.x - 2017-12-10
  - safely re-enabled axlsx by using the master branch and upgradeing rubyzip

* **v0.2.6** - compatible with 0.2.x - 2017-12-08
  - allow ssh/scp options to be passed

* **v0.2.5** - compatible with 0.2.x - 2017-11-30
  - removed a reference to AXLSX in scp transfers *(haven't figured out how to test that yet!)*

* **v0.2.4** - compatible with 0.2.x - 2017-11-30
  - rubyzip 1.1.7 - has a serious security flaw - Axlsx and Roo cannot use rubyzip 1.2.1 -- YET (which doesn't have the flaw) - so xlsx features are disabled until rubyzip 1.2.1 can be used by both roo and axlsx.  **CSV** conversions are still usable.  **BIG THANKS TO GitHub for the notification!**

* **v0.2.3** - compatible with 0.2.x - 2017-11-23
  - allow detailed queries *(_by_id & _by_status)* to skip payment information
  - allow array, csv & xlsx transformations to skip payment queries (when no payment_info requested)

* **v0.2.2** - compatible with 0.2.x - 2017-11-21
  - refactor and test url timeouts
  - refactor openapply client

* **v0.2.1** - compatible with 0.2.x - 2017-11-20
  - convert api data into an array, csv or xlsx
  - allow data flattening prep for post processing
  - allow queries to lookup students with multiple statuses
  - allow scp string object to file export (no automated tests)

* **v0.2.0** - first release -- **NOT** compatible with 0.1.0 -- 2017-11-07
  - get student details of a give status (and pure api calls)
  - recursive query until all receipt of all records received

* **v0.1.0** - test release -- 2017-11-01
