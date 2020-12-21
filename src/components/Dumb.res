module Fragment = %relay.fragment(
  `
    fragment DumbUserFragment on User {
      login
      name
    }
  `
)

@react.component
let make = (~user as userRef, ~submit) => {
  let user = Fragment.use(userRef)

  React.useEffect(() => {
    submit([user.login])
    Some(() => ())
  })

  React.null
}
