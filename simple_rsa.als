// Simple RSA algorithm. This very simple model only allows Alice to send messages to Bob.
// A reach goal may be to implement a model that works in a way that actually represents 
// how this looks on a network where 
abstract sig State{}
one sig Decrypt, Encrypt extends State{}
abstract sig Step{}

abstract sig Host{
  var state: State,
 // lone privatekey: PrivateKey,
  //lone publickey: PublicKey,
 // one message: Message
}

one sig Bob {
  var privatekey: PrivateKey
}

one sig Alice {
  var publickey: PublicKey
  message: Message
}
one sig Message {
  var state: State
}

one sig PublicKey {
  var value: Int 
}

one sig PrivateKey {
  var value: Int
}
one sig Alice, Bob extends Host {}

//fact{
 // no Alice.privatekey 
 // no Bob.publickey
 // some Alice.publickey
 // some Bob.privatekey
//}




