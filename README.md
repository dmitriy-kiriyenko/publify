# EC2 Ruby on Rails test

1. Clone the repo on EC2 machine.
2. Run `bin/fresh_ubuntu_perftest_setup.sh`.
3. Start the server.
4. Run `bin/perftest.sh http://127.0.0.1:3000/search/aaa 100` where 100 is the number of iterations you want to run.
5. Run `rspec spec/performance/sample_spec.rb`
6. Study the results. 
