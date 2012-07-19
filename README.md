## Mocha integration with MiniTest without monkey-patching

Running the test shown below demonstrates Mocha and MiniTest operating together in perfect harmony without the aid of monkey-patching. See [`Mocha::Integration::MiniTest`](https://github.com/freerange/mocha-without-monkey-patching/blob/master/lib/mocha/integration/mini_test.rb) for the gory details. Note that this relies on an as yet unreleased version of Mocha (specifically for the  `Mocha::ExpectationErrorFactory.exception_class` behaviour).

There are 10 tests in all and 9 of them should fail. Only the tests with expectations or assertions should count in the number of assertions (i.e. not the tests with unexpected invocations), making 6 in total.

I'm pretty confident that partial mocking should behave the same as full mocking, so I've only included two partial mocking tests (the ones with `real_object` in their names).

I haven't yet looked into what happens with errors as opposed to failures - this is relevant when thinking about some of the Mocha configuration options (e.g. `Mocha::Configuration.prevent(:stubbing_non_existent_method)`).

```
bundle install
ruby -Itest test/foo_test.rb

Run options: --seed 22963

# Running tests:

FFFFF.FFF.

Finished tests in 0.010722s, 932.6618 tests/s, 559.5971 assertions/s.

  1) Failure:
test_real_object_unsatisfied_expectation(FooTest) [test/foo_test.rb:65]:
not all expectations were satisfied
unsatisfied expectations:
- expected exactly once, not yet invoked: #<Object:0x7f90cf063490>.expected(any_parameters)


  2) Failure:
test_mock_object_unexpected_invocation_in_teardown(FooTest) [test/foo_test.rb:20]:
unexpected invocation: #<Mock:not expecting invocation>.unexpected()


  3) Failure:
test_assertion_unsatisfied(FooTest) [test/foo_test.rb:44]:
Epic Fail!

  4) Failure:
test_mock_object_unexpected_invocation(FooTest) [test/foo_test.rb:49]:
unexpected invocation: #<Mock:not expecting invocation>.unexpected()


  5) Failure:
test_mock_object_unsatisfied_expectation_in_setup(FooTest) [test/foo_test.rb:13]:
not all expectations were satisfied
unsatisfied expectations:
- expected exactly once, not yet invoked: #<Mock:expecting invocation>.expected(any_parameters)


  6) Failure:
test_mock_object_unsatisfied_expectation(FooTest) [test/foo_test.rb:54]:
not all expectations were satisfied
unsatisfied expectations:
- expected exactly once, not yet invoked: #<Mock:expecting invocation>.expected(any_parameters)


  7) Failure:
test_mock_object_unexpected_invocation_in_setup(FooTest) [test/foo_test.rb:10]:
unexpected invocation: #<Mock:not expecting invocation>.unexpected()


  8) Failure:
test_real_object_unexpected_invocation(FooTest) [test/foo_test.rb:60]:
unexpected invocation: #<Object:0x7f90cf045d28>.unexpected()
unsatisfied expectations:
- expected never, invoked once: #<Object:0x7f90cf045d28>.unexpected(any_parameters)


  9) Failure:
test_real_object_unexpected_invocation(FooTest) [test/foo_test.rb:59]:
not all expectations were satisfied
unsatisfied expectations:
- expected never, invoked once: #<Object:0x7f90cf045d28>.unexpected(any_parameters)


10 tests, 6 assertions, 9 failures, 0 errors, 0 skips
```

