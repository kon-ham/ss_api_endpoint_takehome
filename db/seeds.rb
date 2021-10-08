# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(
    email: 'abc@gmail.com',
    password: '123456'
)

tournament1 = Tournament.create!(
    name: "SuperToll 2012",
    city: "Charlotte",
    state: "NC", 
    start_date: "2012-01-01"
)

team1 = Team.create!(
    name: "The Bobcats", 
    age_group: "N/A", 
    coach: "Bob McBobster",
    tournament_id: tournament1.id
)

Player.create!(
    first_name: "Leigh",
    last_name: "Pulzone",
    height: "60",
    weight: "250",
    birthday: "1989-07-17",
    graduation_year: 2008,
    position: "Linebacker",
    recruit: true,
    team_id: team1.id
)

