/*
	This is a very simple RSA model that is essentially a temporal version of the classic "Alice and Bob" cryptography scheme.
*/

abstract sig State{}

one sig Decrypted, Encrypted, Original extends State{}

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

// Define these on a granularity level of a singular message (to allow free movement of messages across the network)
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
      m not in Bob.message and m not in Alice.message <=> m.state = Encrypted and m.status = Cipher
      m in Encrypt.message <=> m.status = Cipher
    }
  }

  always {
    eventually {
       Message.state = Decrypted -- we eventually want all messages to be decrypted. This removes the possibility of a message becoming "stuck" on the network.
    }
  }
  
}


run {
  #Message = 1 -- run for a singular message at first. 
} 

pred doNothing[m: Message]{
  m.state' = m.state 
  m.status' = m.status
}

pred encrypt[m: Message]{
  --Preconditions
  m.state = Original
  m.status = Plaintext

  --Actions to be taken
  m.state' = Encrypted -- set this to be encrypted
  m.status' = Cipher
  m in Encrypt.message'
}


pred decrypt[m: Message]{
  -- Preconditions
  m.state = Encrypted
  m.status = Cipher
  
  -- Actions
  m.state' = Decrypted
  m.status' = Plaintext
  m not in Encrypt.message'
}



