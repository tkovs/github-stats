module Hello = {
  [@react.component]
  let make = () => <h1> {React.string("Hello")} </h1>;
};

ReactDOMRe.renderToElementWithId(<Hello />, "root");
