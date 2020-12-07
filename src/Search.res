%%raw(`require('./styles/search.css')`)

@react.component
let make = (~submit) => {
  let (login, setLogin) = React.useState(_ => "")

  let onSubmit = (e: ReactEvent.Form.t): unit => {
    ReactEvent.Form.preventDefault(e)
    login->submit
  }

  <div className="ui middle aligned centered grid" id="search">
    <div className="fourteen wide mobile eight wide tablet four wide computer column">
      <img
        className="ui image small centered"
        src="https://github.githubassets.com/images/modules/logos_page/Octocat.png"
      />
      <h2 className="ui header centered">
        <div className="content"> {React.string("Githubr")} </div>
      </h2>
      <form className="ui fluid" onSubmit>
        <div className="ui left icon input large fluid">
          <i className="user icon" />
          <input
            type_="text"
            name="login"
            value=login
            placeholder="Find a user by the login"
            onChange={e => (e->ReactEvent.Form.target)["value"] |> setLogin}
            maxLength=64
          />
        </div>
      </form>
    </div>
  </div>
}
