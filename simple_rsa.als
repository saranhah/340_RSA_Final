// Simple RSA algorithm. This very simple model only allows Alice to send messages to Bob.
// A reach goal may be to implement a model that works in a way that actually represents 
// how this looks on a network where we change the granularity so that both alice and bob 
// are 
abstract sig State{}

one sig Decrypted, Encrypted, Original, OnNetwork extends State{}

abstract sig Status {}

one sig Plaintext, Cipher, Decrypting extends Status{}


one sig Encrypt {
  var message: set Message,
  connection: Decrypt
}

one sig Decrypt {
  var message: set Message,
  connection: Bob
}

one sig Bob {
  key: PrivateKey,
  var message: set Message
}

one sig Alice {
  key: PublicKey,
  var message: set Message,
  connection: Encrypt
}

sig Message {
  var state: State,
  var status: Status
}

one sig PublicKey {}

one sig PrivateKey {}

pred init {
  -- Initial state. We want there to be some message that belongs to alice and no other messages
  some Alice.message
  Message.state = Original
  Message.status = Plaintext
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

  always {
    all m: Message | {
      m in Alice.message <=> m.state = Original and m.status = Plaintext
      m in Bob.message <=> m.state = Decrypted and m.status = Plaintext
      --m.state = OnNetwork <=> m not in Bob.message and m not in Alice.message
      m not in Bob.message and m not in Alice.message <=> m.state = Encrypted and m.status = Cipher
      m in Encrypt.message <=> m.status = Cipher
    }
  }
  always {
    eventually {
       Message.state = Decrypted -- we eventually want all messages to be decrypted
    }
  }
  
}


run {
  #Message = 1
} 

pred doNothing[m: Message]{
  m.state' = m.state -- this is the only thing that stays the same. other things can possibly change at same time
  m.status' = m.status
}

pred encrypt[m: Message]{
  // Preconditions
  m.state = Original
  m.status = Plaintext

  // Actions to be taken
  m.state' = Encrypted -- set this to be encrypted
  m.status' = Cipher
  m in Encrypt.message'
}

/*pred deliver[m: Message]{
  -- Preconditions 
  m.state = OnNetwork
  m.status = Decrypting

  -- Actions
  m.state' = Decrypted
  m.status' = Plaintext

}
*/
pred decrypt[m: Message]{
  -- Preconditions
  m.state = Encrypted
  m.status = Cipher
  
  -- Actions
  m.state' = Decrypted
  m.status' = Plaintext
  m not in Encrypt.message'
}




// WTS: 
/*
 - only messages that are encrypted are ciphers
 - only messages that are decryped/originally in plaintext are readable


*/

