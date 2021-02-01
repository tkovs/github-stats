<h1 align="center">
  <br>
  Github Stats
</h1>

<h4 align="center">
  Github profile stats with ReScript, React and GraphQL.
</h4>
<p align="center">
  <img alt="GitHub top language" src="https://img.shields.io/github/languages/top/tkovs/github-stats.svg">

  <img alt="GitHub language count" src="https://img.shields.io/github/languages/count/tkovs/github-stats.svg">
  
  <img alt="GitHub commit activity" src="https://img.shields.io/github/commit-activity/m/tkovs/github-stats.svg">

  <img alt="Repository size" src="https://img.shields.io/github/repo-size/tkovs/github-stats.svg">
  <br />
  <a href="https://github.com/tkovs/github-stats/commits/master">
    <img alt="GitHub last commit" src="https://img.shields.io/github/last-commit/tkovs/github-stats.svg">
  </a>

  <a href="https://github.com/tkovs/github-stats/issues">
    <img alt="Repository issues" src="https://img.shields.io/github/issues/tkovs/github-stats.svg">
  </a>

  <img alt="GitHub" src="https://img.shields.io/github/license/tkovs/github-stats.svg">
  <!-- <a href="https://travis-ci.org/github/tkovs/pomodoro">
    <img src="https://travis-ci.org/tkovs/pomodoro.svg?branch=master" alt="Build Status" />
  </a> -->

  <br />
  <!-- <img alt="Build status" src="https://api.netlify.com/api/v1/badges/c3404df3-bf7b-45b7-bc01-62175b0423d1/deploy-status"> -->
</p>

<p align="center">
  <a href="#rocket-technologies">Technologies</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
  <a href="#information_source-how-to-run">How To Run</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
  <a href="#runner-next-steps">Next Steps</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
  <a href="#memo-license">License</a>
</p>

## :rocket: Technologies

This project was developed with the following technologies:

- [ReactJS](https://reactjs.org)
- [ReasonML](https://reasonml.github.io)
- [GraphQL](https://graphql.org/)
- [Reason Relay](https://reason-relay-documentation.zth.now.sh/)
- [Semantic UI](https://semantic-ui.com/)

## :information_source: How To Run

To clone and run this application, you'll need [Git](https://git-scm.com), [Node.js](https://nodejs.org/en/) + [Yarn](https://yarnpkg.com/) (you can use npm instead) installed on your computer. You also need a Github token with access to the Github features. From your command line:

```bash
# Clone this repository
$ git clone https://github.com/tkovs/github-stats
# Or
$ gh repo clone tkovs/github-stats

# Go into the repository
$ cd github-stats

# Install dependencies
$ yarn 
$ yarn relay

# Run the app on two terminals
$ yarn start
$ yarn server --env.GITHUB_TOKEN=<token>

# Run the tests
$ yarn test

# Update snapshots
$ yarn test -u
```

## :runner: Next steps

- [x] Init project
- [ ] ...

## :memo: License

This project is under the MIT license. See the [LICENSE](https://github.com/tkovs/reason-pomodoro/blob/master/LICENSE) for more information.

---

Made with ♥ by tkovs :wave: [Get in touch!](https://www.linkedin.com/in/tkovs/)
