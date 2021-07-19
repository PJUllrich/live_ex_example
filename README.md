# LiveX Example Repo

`LiveX` is a work-in-progress library for handling `State` changes in a [Phoenix LiveView](https://github.com/phoenixframework/phoenix_live_view) application according to the [Flux](https://facebook.github.io/flux/) pattern.

The current implementation is heavily inspired by the [Vuex](https://vuex.vuejs.org/) project.

## How to set up
1. Copy the logic of the [store.ex](https://github.com/PJUllrich/LiveX_example/blob/master/lib/live_view_test_web/store/store.ex) file into your Project.
2. Add the line `defdelegate handle_info(msg, socket), to: Store` to any `LiveView` controller in which you want to use `Store`.
3. In your parent/root/outermost `LiveView` instance initiate the Store with `{:ok, Store.init(socket)}` in the `mount/2` function.
4. In any child `LiveView` instance, join the `Store` instance with `{:ok, Store.join(params, socket)}`.
5. Initiate any `State` changes with the `Store.dispatch/2` function.
6. Use the state in your `.leex` templates with `@state.your_variable`

## TODOs
1. Compare the performance of storing all variables in a single `state` assignment vs. splitting up the variables into separate assignments.