# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

products = Product.create(
  [
  { name: 'Chicken Breast', quantity: '850g' , price: 89 }, 
  { name: 'Pork fillet', quantity: '500g' , price: 50 }, 
  { name: 'Prosciutto ', quantity: '80g' , price: 22 },
  { name: 'Sausages ', quantity: '240g ', price: 22 },
  { name: 'Hamburgers', quantity: '4-pack' , price: 42 },
  { name: 'Banana', quantity: '180g', price: 19 },
  { name: 'Potato', quantity: '1kg', price: 11 },
  { name: 'Lemons', quantity: '500g', price: 22 },
  { name: 'Onion', quantity: '1kg', price: 9 },
  { name: 'Mushrooms', quantity: '1kg', price: 29 },
  { name: 'Spinach', quantity: '250g', price: 27 },
  { name: 'Carrots', quantity: '1kg', price: 11 },
  { name: 'Eggs', quantity: '10p', price: 26 },
  { name: 'Milk', quantity: '1.5l' , price: 12 },
  { name: 'Butter', quantity: '500g' , price: 38 },
  { name: 'Västerbotten', quantity: '1kg', price: 74 },
  { name: 'Nutella', quantity: '630g', price: 41 },
  { name: 'Tortilla', quantity: '8p', price: 10 }, 
  { name: 'Oil', quantity: '1l', price: 13 }, 
  { name: 'Toilet paper', quantity: '12p' , price: 50 },
  { name: 'Salt', quantity: '125g' , price: 4 },
  { name: 'Ibuprofen ', quantity: '400mg' , price: 50 },
  { name: 'Baguette ', quantity: '1p' , price: 10 }, 
  { name: 'Rice', quantity: '500g ' , price: 24 }
  ])