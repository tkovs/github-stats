ReactExperimental.renderConcurrentRootAtElementWithId(
  <ReasonRelay.Context.Provider environment=RelayEnv.environment>
    <React.Suspense fallback={<div> {React.string("Loading...")} </div>}>
      <App />
    </React.Suspense>
  </ReasonRelay.Context.Provider>,
  "root",
);