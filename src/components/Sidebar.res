let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]

@react.component
let make = (~user: AppUserQuery_graphql.Types.response_user) => {
  let createdAt = user.createdAt->Js.Date.fromString
  let day = createdAt->Js.Date.getDay
  let month = months[createdAt->Js.Date.getMonth->int_of_float]
  let year = createdAt->Js.Date.getFullYear
  let followers = user.followers.totalCount
  let following = user.following.totalCount
  let starredRepositories = user.starredRepositories.totalCount

  <div className="sixteen wide mobile four wide computer column vh-100" id="sidebar">
    <img className="ui image medium circular" src=user.avatarUrl />
    <h2 className="ui header">
      {"Vitor Rodrigues"->React.string}
      <div className="sub header"> {user.login->React.string} </div>
    </h2>
    {switch user.bio {
    | None => React.null
    | Some(bio) => <p className="f4"> {bio->React.string} </p>
    }}
    <a className="ui fluid button" href={"https:github.com/" ++ user.login}>
      <i className="github icon" /> {"Go to github"->React.string}
    </a>
    <div className="ui divider" />
    <div className="flex mt4">
      <div className="ui basic label">
        <i className="user icon" />
        {(string_of_int(user.following.totalCount) ++ " following")->React.string}
      </div>
      <div className="ui basic label">
        <i className="user icon" />
        {(string_of_int(user.followers.totalCount) ++ " followers")->React.string}
      </div>
    </div>
    <div className="flex mt4">
      <div className="ui basic label">
        <i className="star icon" />
        {(string_of_int(user.starredRepositories.totalCount) ++ " starred repositories")
          ->React.string}
      </div>
    </div>
    <div className="mt4">
      <p className="f5">
        {"Joined Github "->React.string}
        {day->React.float}
        {" "->React.string}
        {month->React.string}
        {" "->React.string}
        {year->React.float}
      </p>
    </div>
    <div className="mt4">
      {switch user.company {
      | None => React.null
      | Some(company) => <> <i className="suitcase icon" /> {company->React.string} <br /> </>
      }}
      {switch user.location {
      | None => React.null
      | Some(location) => <>
          <i className="map marker alternate icon" /> {location->React.string} <br />
        </>
      }}
      <i className="envelope icon" />
      {user.email->React.string}
      <br />
      {switch user.websiteUrl {
      | None => React.null
      | Some(websiteUrl) => <>
          <i className="linkify icon" />
          <a className="link" href={websiteUrl}> {websiteUrl->React.string} </a>
          <br />
        </>
      }}
      {switch user.twitterUsername {
      | None => React.null
      | Some(twitterUsername) => <>
          <i className="twitter icon" />
          <a className="b" href={twitterUsername}> {("@" ++ twitterUsername)->React.string} </a>
          <br />
        </>
      }}
    </div>
    //   <div className="ui statistics">
    //     <div className="statistic">
    //       <div className="value"> {user.forkedRepositories.totalCount->React.int} </div>
    //       <div className="label"> {"Forks"->React.string} </div>
    //     </div>
    //     <div className="statistic">
    //       <div className="value"> {user.notForkedRepositories.totalCount->React.int} </div>
    //       <div className="label"> {"Sources"->React.string} </div>
    //     </div>
    //   </div>
  </div>
}
