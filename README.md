# Components in Elm

This is a simple example of how components can be implemented in an Elm application. It is meant to
be a minimal example focusing just on the basic idea, adapted from the way this is done in libraries
such as [elm-mdl](https://github.com/debois/elm-mdl) and
[elm-sortable-table](https://github.com/evancz/elm-sortable-table).

In this context, "component" means a small reusable subapplication that needs its own model as well
as update and view functions. The general
[advice](https://guide.elm-lang.org/webapps/structure.html) is to avoid thinking too much in terms
of components because separating them out usually adds unnecessary complexity. I try only to create
them when all of the following conditions are met:

* the component is used in more than one place,
* the component has some state to maintain, and
* the component needs its own messages (for e.g. button click events).

When you do end up creating a component you'll want to ensure that the component's state is kept
only in one place, namely in its parent's model, to prevent any synchronisation bugs.

## The `Counter` component

In this case we have a [`Counter`](src/Counter.elm) component whose view function renders a counter
along with buttons for incrementing and decrementing. The [`Main`](src/Main.elm) module creates two
instances of this component, showing one on the left and one on the right side of the page.

A `Counter` keeps track of the current counter value (as well as a title) in its model. It defines
messages for changing the value but these are not exposed -- only its `Msg` type is. The key
features of this way of implementing components are

* the parent module keeps track of the models of any components it uses,
* the parent module defines a type for messages from components it uses and delegates handling these
  to the component's `update` function, and
* the parent module calls a component's `view` function to render it.

This is a pretty clean way of creating components when you need to, which is useful for larger
pieces of functionality (e.g. a date picker) that you want to use in multiple places.

A slightly more advanced feature missing from this example is allowing the parent to handle certain
messages sent by the component, which can be implemented by passing a configuration parameter to the
view function. You can also allow components to define their own subscriptions which would have to
be mapped to the component's messages by the parent.
