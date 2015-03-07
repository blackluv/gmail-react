
ThreadList = React.createClass
  getInitialState: ->
    threads: []

  componentDidMount: ->
    $.ajax(
      url: '/api/threads/index.json'
      cache: false
    ).then (threads)=>
      @setState threads: threads

  render: ->
    <ul id="threads">
      { for thread in @state.threads
        <ThreadItem thread={thread} />
      }
    </ul>

ThreadItem = React.createClass
  render: ->
    thread = @props.thread
    lastMessage = thread.last_message
    console.log thread.unread
    threadClasses = React.addons.classSet(unread: thread.unread)

    <li className={ threadClasses }>
      <a>
        <time>{ lastMessage.created_at }</time>
        <span className="check"></span>
        <span className="people">
          { for person in thread.participants
            <span className="name unread">{ person.first_name } { person.last_name }</span>
          }
        </span>
        <span className="subject">{ lastMessage.subject }</span>
        <span className="body">- { lastMessage.snippet }</span>
      </a>
    </li>

React.render <ThreadList />, document.getElementById('content')
