// NOTE: The contents of this file will only be executed if
// you uncomment its entry in "assets/js/app.js".

// Bring in Phoenix channels client library:
import {Socket} from "phoenix"

// And connect to the path in "lib/nutrition_web/endpoint.ex". We pass the
// token for authentication. Read below how it should be used.
let socket = new Socket("/socket", {params: {token: window.userToken}})

// When you connect, you'll often need to authenticate the client.
// For example, imagine you have an authentication plug, `MyAuth`,
// which authenticates the session and assigns a `:current_user`.
// If the current user exists you can assign the user's token in
// the connection for use in the layout.
//
// In your "lib/nutrition_web/router.ex":
//
//     pipeline :browser do
//       ...
//       plug MyAuth
//       plug :put_user_token
//     end
//
//     defp put_user_token(conn, _) do
//       if current_user = conn.assigns[:current_user] do
//         token = Phoenix.Token.sign(conn, "user socket", current_user.id)
//         assign(conn, :user_token, token)
//       else
//         conn
//       end
//     end
//
// Now you need to pass this token to JavaScript. You can do so
// inside a script tag in "lib/nutrition_web/templates/layout/app.html.heex":
//
//     <script>window.userToken = "<%= assigns[:user_token] %>";</script>
//
// You will need to verify the user token in the "connect/3" function
// in "lib/nutrition_web/channels/user_socket.ex":
//
//     def connect(%{"token" => token}, socket, _connect_info) do
//       # max_age: 1209600 is equivalent to two weeks in seconds
//       case Phoenix.Token.verify(socket, "user socket", token, max_age: 1_209_600) do
//         {:ok, user_id} ->
//           {:ok, assign(socket, :user, user_id)}
//
//         {:error, reason} ->
//           :error
//       end
//     end
//
// Finally, connect to the socket:
socket.connect()

// Now that you are connected, you can join channels with a topic.
// Let's assume you have a channel with a topic named `room` and the
// subtopic is its id - in this case 42:
let channel = socket.channel("macro_tracker:lobby", {})
channel.join()
  .receive("ok", resp => { console.log("Joined successfully", resp) })
  .receive("error", resp => { console.log("Unable to join", resp) })

    //~~~~~~~~~ JS code for handling the chat box~~~~~~~~

    // Chat box temporatily disabled

    // document.getElementById('chat-form').addEventListener('submit', function(e){
    //   e.preventDefault()
  
    //   let userName = document.getElementById('user-name').value
    //   let userMsg = document.getElementById('user-msg').value
  
    //   channel.push('shout-chat', {name: userName, body: userMsg})
  
    //   document.getElementById('user-name').value = ''
    //   document.getElementById('user-msg').value = ''
    // })
  
    // channel.on('shout-chat', payload => {
    //   let chatBox = document.querySelector('#chat-box')
    //   let msgBlock = document.createElement('p')
  
    //   msgBlock.insertAdjacentHTML('beforeend', `${payload.name}: ${payload.body}`)
    //   chatBox.appendChild(msgBlock)
    // })
  
    //~~~~~~~~~ JS code for handling the food log ~~~~~~~~

    document.getElementById('food-form').addEventListener('submit', function(e){
      e.preventDefault()
  
      let user = document.getElementById('item-user').value
      let food = document.getElementById('item-food').value
      let cals = document.getElementById('calories').value
      let prot = document.getElementById('proteins').value
      let carb = document.getElementById('carbohydrates').value
      let fats = document.getElementById('fats').value
  
      channel.push('shout-food', {username: user, food: food, calories: cals, proteins: prot, carbohydrates: carb, fats: fats})
      
      document.getElementById('item-user').value = 'Geordie'
      document.getElementById('item-food').value = ''
      document.getElementById('calories').value = ''
      document.getElementById('proteins').value = ''
      document.getElementById('carbohydrates').value = ''
      document.getElementById('fats').value = ''

    })

    channel.on('shout-food', payload => {
      let chatBox = document.querySelector('#food-box')
      let msgBlock = document.createElement('p')
  
      msgBlock.insertAdjacentHTML('beforeend', `${payload.food}  ${payload.calories} ${payload.proteins} ${payload.carbohydrates} ${payload.fats}`)
      chatBox.appendChild(msgBlock)
    })


export default socket
