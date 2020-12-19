%%raw(`require('./styles/index.css')`)
%%raw(`require('vtex-tachyons/tachyons.css')`)

module Query = %relay.query(
  `
    query AppUserQuery ($login: String!) {
      user(login: $login) {
        ...SidebarUserFragment
      }
    }
  `
)

@react.component
let make = () => {
  let (login, setLogin) = React.useState(_ => "")
  let query = Query.use(~variables={login: login}, ())

  {
    switch query {
    | {user: None} => <Search submit={login => setLogin(_ => login)} />
    | {user: Some(user)} => <>
        <Navbar submit={value => setLogin(_ => value)} />
        <div className="ui container grid"> <Sidebar user=user.fragmentRefs /> <Content /> </div>
      </>
    }
  }
}
