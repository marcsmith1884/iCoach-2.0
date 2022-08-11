User.create(email: "hurling@example.com", password: "hurling@example.com", password_confirmation: "hurling@example.com")
User.create(email: "player1@example.com", password: "player1@example.com", password_confirmation: "player1@example.com")
User.update_all confirmed_at: DateTime.now



Training.create(name: "Hurling")
Training.create(name: "Gaelic")
Training.create(name: "Gym")

Location.create(name: "Balheary", duration: 45)
Location.create(name: "Lawless Park", duration: 55)
