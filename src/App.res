%%raw(`require('./styles/index.css')`)
%%raw(`require('vtex-tachyons/tachyons.css')`)

module Query = %relay.query(
  `
    query AppUserQuery ($login: String!) {
      user(login: $login) {
        avatarUrl
        bio
        company
        createdAt
        email
        followers {
          totalCount
        }
        following {
          totalCount
        }
        location
        login
        name
        twitterUsername
        starredRepositories {
          totalCount
        }
        websiteUrl
        forkedRepositories: repositories(isFork: true) {
          totalCount
        },
        notForkedRepositories: repositories(isFork: false) {
          totalCount
        }
      }
    }
  `
)

@react.component
let make = () => {
  let (login, setLogin) = React.useState(_ => "")
  let user = Query.use(~variables={login: login}, ())

  {
    switch user {
    | {user: None} => <Search submit={login => setLogin(_ => login)} />
    | {user: Some(user)} => <>
        <Navbar submit={value => setLogin(_ => value)} />
        <div className="ui container grid"> <Sidebar user /> <Content /> </div>
      </>
    }
  }
}
