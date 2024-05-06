// Simple RSA algorithm. This very simple model only allows Alice to send messages to Bob.
// A reach goal may be to implement a model that works in a way that actually represents 
// how this looks on a network where we change the granularity so that both alice and bob 
// are 
abstract sig State{}
one sig Decrypted, Encrypted, Plaintext extends State{}

abstract sig Step{}

one sig Bob {
  key: PrivateKey,
  var message: set Message
}

one sig Alice {
  key: PublicKey,
  var message: set Message
}

sig Message {
  var state: State
}

one sig PublicKey {}

one sig PrivateKey {}

pred init {
  -- Initial state. We want there to be some message that belongs to alice and no other messages
  some Alice.message
  Message.state = Plaintext
}
// Define these on a message granularity level
fact validTraces{
  init
  always {
    all m: Message | {
      encrypt[m] or 
      decrypt[m] or 
      doNothing[m]
    }
  }
/*
  always {
    all data: Alice.message | data.state = Plaintext
    all decrypt: Bob.message | decrypt.state = Decrypted
  }*/
  always {
    all m: Message | {
      m in Alice.message <=> m.state = Plaintext
      m in Bob.message <=> m.state = Decrypted
      m not in Alice.message and m not in Bob.message <=> m.state = Encrypted
    }
  }
  always {
    eventually {
       Message.state = Decrypted -- we eventually want all messages to be decrypted
    }
}
  
  -- want to model that eventually all of them will be decrypted
  --always (eventually all m: Message | m.state = Decrypted)
}


run {
  #Message >= 4
} for 5
pred doNothing[m: Message]{
  m.state' = m.state -- this is the only thing that stays the same. other things can possibly change at same time
}

pred encrypt[m: Message]{
  // Preconditions
  m.state = Plaintext

  // Actions to be taken
  m.state' = Encrypted -- set this to be encrypted
}

pred decrypt[m: Message]{
  -- Preconditions
  m.state = Encrypted
  
  -- Actions
  m.state' = Decrypted
}




// WTS: 
/*
 - only messages that are encrypted are ciphers
 - only messages that are decryped/originally in plaintext are readable


*/

