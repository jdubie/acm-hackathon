App = require 'app'

App.Router.map (match) ->
  match('/').to('home')

App.HomeRoute = Em.Route.extend
  setupControllers: (controller) ->
    for company in window.RAW.companies
      App.Company.createRecord(company)
    controller.set('content', App.store.all(App.Company))

window.RAW = {
"companies": [
 {
    "_id": 1,
    "name": "Facebook",
    "amount_raised": 16000000000.0,
    "category_code": "web",
    "number_of_employees": 9049,
    "founded_year": 2004,    
    "description": "Social network",    
    "overview": "Facebook is the world’s largest social network, with over 1 billion monthly active users.",    
    "image": "assets/images/resized/0000/4561/4561v1-max-450x450.png",
    "crunchbase_url": "http://www.crunchbase.com/company/facebook",
    "number_good_investors": 9,
    "lifeswap_URL": "https://www.thelifeswap.com/facebook"
  },  
 {
    "_id": 2,
    "name": "Airbnb",
    "amount_raised": 120000000.0,
    "category_code": "web",
    "number_of_employees": 300,
    "founded_year": 2007,    
    "description": "Marketplace for unique accommodations",    
    "overview": "Founded in August 2008 and based in San Francisco, California, Airbnb is a trusted community marketplace for people to list, discover, and book unique spaces around the world – online or from a mobile phone. Whether an apartment for a night, a castle for a week, or a villa for month, Airbnb connects people to unique travel experiences, at any price point, in more that 26,000 cities and 192 countries. And with world-class customer service and a growing community of users, Airbnb is the easiest way for people to monetize their extra space and showcase it to an audience of millions.",    
    "image": "assets/images/resized/0002/3133/23133v9-max-450x450.png",
    "crunchbase_url": "http://www.crunchbase.com/company/airbnb",
    "number_good_investors": 9,
    "lifeswap_URL": "https://www.thelifeswap.com/airbnb"
  },  
 {
    "_id": 3,
    "name": "Palantir Technologies",
    "amount_raised": 301000000.0,
    "category_code": "software",
    "number_of_employees": 550,
    "founded_year": 2004,    
    "description": "platforms for integrating information",    
    "overview": "Palantir’s mission is to solve the most important problems for the world’s most important institutions. Palantir was founded in 2004 by a handful of PayPal alumni and Stanford computer scientists. Since then Palantir has doubled in size every year while retaining early-stage values: a startup culture, strong work ethic, and rigorous hiring standards.",    
    "image": "assets/images/resized/0007/3542/73542v3-max-450x450.png",
    "crunchbase_url": "http://www.crunchbase.com/company/palantir-technologies",
    "number_good_investors": 9,
    "lifeswap_URL": "https://www.thelifeswap.com/palantir"
  },      
  {
    "_id": 4,
    "name": "Dropbox",
    "amount_raised": 257000000.0,
    "category_code": "network_hosting",
    "number_of_employees": 221,
    "founded_year": 2007,    
    "description": "Always have your stuff, wherever you are",    
    "overview": "Dropbox was founded in 2007 by Drew Houston and Arash Ferdowsi. Frustrated by working from multiple computers, Drew was inspired to create a service that would let people bring all their files anywhere, with no need to email around attachments. Drew created a demo of Dropbox and showed it to fellow MIT student Arash Ferdowsi, who dropped out with only one semester left to help make Dropbox a reality. Guiding their decisions was a relentless focus on crafting a simple and reliable experience across every computer and phone.",    
    "image": "assets/images/resized/0001/1969/11969v4-max-450x450.png",
    "crunchbase_url": "http://www.crunchbase.com/company/dropbox",
    "number_good_investors": 9,
    "lifeswap_URL": "https://www.thelifeswap.com/dropbox"
  },  
  {
    "_id": 5,
    "name": "Klout",
    "amount_raised": 40000000.0,
    "category_code": "search",
    "number_of_employees": 79,
    "founded_year": 2008,    
    "description": "Measures Online Influence",    
    "overview": "\u003Cp\u003EKlout measures influence based on the ability to drive action across the social web. Any person can connect their social network accounts and Klout will generate a score on a scale of 1-100 that represents their ability to engage other people and inspire social actions. Klout enables everyone to gain insights that help them better understand how they influence others. Klout also provides people with opportunities to shape and be recognized for their influence.\u003C/p\u003E",    
    "image": "assets/images/resized/0003/2657/32657v4-max-450x450.png",
    "crunchbase_url": "http://www.crunchbase.com/company/klout",
    "number_good_investors": 6,
    "lifeswap_URL": "https://www.thelifeswap.com/klout"
  },
  {
    "_id": 6,
    "name": "Zanbato",
    "amount_raised": 4850000.0,
    "category_code": "ecommerce",
    "number_of_employees": 25,
    "founded_year": 2010,    
    "description": "infrastructure and real assets",    
    "overview": "Zanbato offers marketplace, storefront, and transaction management tools to support the workflows of infrastructure, energy, and natural resources transactions.",    
    "image": "assets/images/resized/0013/5726/135726v2-max-450x450.jpg",
    "crunchbase_url": "http://www.crunchbase.com/company/zanbato",
    "number_good_investors": 2,
    "lifeswap_URL": "https://www.thelifeswap.com/zanbato"
  },  
  {
    "_id": 7,
    "name": "Orchestra",
    "amount_raised": 5000000.0,
    "category_code": "web",
    "number_of_employees": 9,
    "founded_year": 2011,    
    "description": "creators of Mailbox",    
    "overview": "Put email in its place. Mailbox.  Two years ago, we set out to build the world’s best mobile collaboration tool. What began with an observation — that people used email as a (terrible) to-do list — evolved into Orchestra To-do, the App Store’s 2011 Productivity App of the Year.  But no matter how much we used Orchestra, people kept sending us tasks via email. And one day it dawned on us: rather than moving these tasks somewhere else, what if we transformed the inbox where they already live?",    
    "image": "assets/images/resized/0014/5157/145157v2-max-450x450.png",
    "crunchbase_url": "http://www.crunchbase.com/company/orchestra",
    "number_good_investors": 3,
    "lifeswap_URL": "https://www.thelifeswap.com/orchestra"
  }
]
}
