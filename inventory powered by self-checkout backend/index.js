const express = require('express');
const mysql = require('mysql2');
const bodyParser = require('body-parser');
const multer = require('multer');
const path = require('path');
const fs = require('fs');

const app = express();
const port = 3000;

const db = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: '',
  database: 'sql_product_inventory2'
});

const order_item_query = `CREATE TABLE IF NOT EXISTS order_items (id INT PRIMARY KEY AUTO_INCREMENT,order_id INT NOT NULL,product_id INT NOT NULL,quantity INT NOT NULL,FOREIGN KEY (order_id) REFERENCES orders(id),FOREIGN KEY (product_id) REFERENCES products(id));`;
const prod_query = `CREATE TABLE IF NOT EXISTS products (id INT PRIMARY KEY AUTO_INCREMENT,name VARCHAR(255) NOT NULL,category VARCHAR(255) NOT NULL,price DECIMAL(10, 2) NOT NULL,barcode VARCHAR(50) NOT NULL,quantity INT NOT NULL,photo VARCHAR(255),UNIQUE (barcode))`;
const order_query = `CREATE TABLE IF NOT EXISTS orders (id INT PRIMARY KEY AUTO_INCREMENT,user_id VARCHAR(255) NOT NULL,order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP);`;



db.connect((err) => {
  if (err) {
    console.error('Unable to connect to MySQL:', err);
  } else {
    console.log('Connected to Database');
    // Execute the create tables query
    db.query(prod_query, (err, results) => {
      if (err) throw err;
      console.log('Products Tables created or already exist');
    });
    db.query(order_query, (err, results) => {
      if (err) throw err;
      console.log('Orders Tables created or already exist');
    });
    db.query(order_item_query, (err, results) => {
      if (err) throw err;
      console.log('Order Items Tables created or already exist');
    });
  }
});



// Middleware
app.use(express.json());
app.use('/uploads',express.static('uploads'));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

// Multer middleware for handling file uploads
const storage = multer.diskStorage({
  destination: './uploads/',
  filename: function (req, file, cb) {
    cb(null, file.fieldname + '-' + Date.now() + path.extname(file.originalname));
  }
});

const upload = multer({ storage: storage });

// Routes
app.get('/products', (req, res) => {
  try{
    db.query('SELECT * FROM products ', (err, results) => {
    if (err) throw err;
      res.json(results);
    });
  }catch(err){
    console.error({"Error occured at delete product api \nError ":err});
    throw ({"Error occured at delete product api \nError ":err});
  }
});

app.post('/products', upload.single('photo'), (req, res) => {
  try{
    const { name, category, price, barcode, quantity } = req.body;
    const photo = req.file.filename;

    db.query('INSERT INTO products (name, category, price, barcode, quantity, photo) VALUES (?, ?, ?, ?, ?, ?)',
      [name, category, price, barcode, quantity, `:${port}/uploads/${photo}`],
      (err, results) => {
        if (err) throw err;
        res.send({"msg":'Product added successfully'});
      });
  }catch(err){
    console.error({"Error occured at add product api \nError ":err});
    throw ({"Error occured at add product api \nError ":err});
  }
});

// ... (previous code)

// Update a product
app.put('/products/:id',upload.single('photo'), (req, res) => {
    try{
      const productId = req.params.id;
      const { name, category, price, barcode, quantity } = req.body;
      db.query('UPDATE products SET name=?, category=?, price=?, barcode=?, quantity=? WHERE id=?',
        [name, category, price, barcode, quantity, productId],
        (err, results) => {
          if (err) throw err;
          res.send({"msg":'Product updated successfully'});
        });
    }catch(err){
      console.error({"Error occured at update product api \nError ":err});
      throw ({"Error occured at update product api \nError ":err});
    }
  });
  
  // Delete a product
  app.delete('/products/:id', (req, res) => {
    try{
      const productId = req.params.id;

      db.query('SELECT * FROM products WHERE id=?',[productId], (err, results) => {
        if (err) throw err;
        // console.log(results[0].photo);
        const imagePath = "./uploads/"+results[0].photo;
        // console.log({imagePath});
        if (fs.existsSync(imagePath)) {
          fs.unlinkSync(imagePath);
          console.log('Product image deleted:', imagePath);
          db.query('DELETE FROM products WHERE id=?', [productId], (err, results) => {
            if (err) throw err;
            // console.log(results);
            res.send({"msg":'Product deleted successfully'});
          });
        }
      });
  
    }catch(err){
      console.error({"Error occured at delete product api \nError ":err});
      throw ({"Error occured at delete product api \nError ":err});
    }
  });
  
  // ... (remaining code)

  // ... (previous code)

// Create a product order
// app.post('/orders', (req, res) => {
//     const { userId, products } = req.body;
  
//     // Assuming the request body has the following structure:
//     // { "userId": 1, "products": [{"productId": 1, "quantity": 2}, {"productId": 2, "quantity": 1}] }
  
//     // Start a MySQL transaction
//     db.beginTransaction((err) => {
//       if (err) throw err;
  
//       // Insert into orders table
//       db.query('INSERT INTO orders (user_id) VALUES (?)', [userId], (err, results) => {
//         if (err) {
//           return db.rollback(() => {
//             throw err;
//           });
//         }
  
//         const orderId = results.insertId;
  
//         // Insert into order_items table for each product
//         const values = products.map(product => [orderId, product.productId, product.quantity]);
  
//         db.query('INSERT INTO order_items (order_id, product_id, quantity) VALUES ?', [values], (err, results) => {
//           if (err) {
//             return db.rollback(() => {
//               throw err;
//             });
//           }
  
//           // Commit the transaction
//           db.commit((err) => {
//             if (err) {
//               return db.rollback(() => {
//                 throw err;
//               });
//             }
  
//             res.send('Order placed successfully');
//           });
//         });
//       });
//     });
//   });

app.post('/orders', (req, res) => {
  // console.log(req.body);
  try {
    const { userId, products } = req.body;
    // console.warn(req.body);
    // Start a MySQL transaction
    db.beginTransaction((err) => {
      if (err) throw err;

      // Insert into orders table
      db.query('INSERT INTO orders (user_id) VALUES (?)', [userId], (err, orderResults) => {
        if (err) {
          return db.rollback(() => {
            throw err;
          });
        }

        const orderId = orderResults.insertId;

        // Update product quantities and insert into order_items table for each product
        const values = products.map(product => [orderId, product.productId, product.quantity]);

        db.query('INSERT INTO order_items (order_id, product_id, quantity) VALUES ?', [values], (err, itemResults) => {
          if (err) {
            return db.rollback(() => {
              throw err;
            });
          }

          // Update product quantities in the inventory
          const updateQuantities = products.map(product => {
            db.query('UPDATE products SET quantity = quantity - ? WHERE id = ?', [product.quantity, product.productId], (err) => {
              if (err) {
                return db.rollback(() => {
                  throw err;
                });
              }
            });
          });

          // Execute all update queries
          db.commit((err) => {
            if (err) {
              return db.rollback(() => {
                throw err;
              });
            }

            res.json({"msg":'Order placed successfully',orderId});
          });
        });
      });
    });
  } catch (err) {
    console.error({"Error occured at place order api \nError ":err});
    throw ({"Error occured at place order api \nError ":err});
  }
});
  
  // ... (remaining code)

  // ... (previous code)

// Get billing information for an order
app.get('/orders/:orderId/billing', (req, res) => {
    try {
      const orderId = req.params.orderId;
  
      db.query(
        'SELECT order_items.product_id, products.name, order_items.quantity, products.price ' +
        'FROM order_items ' +
        'JOIN products ON order_items.product_id = products.id ' +
        'WHERE order_items.order_id = ?',
        [orderId],
        (err, results) => {
          if (err) throw err;
    
          let totalAmount = 0;
    
          results.forEach((item) => {
            totalAmount += item.quantity * item.price;
          });
    
          res.json({ orderId, totalAmount, "items":results});
        }
      );
    } catch (err) {
      console.error({"Error occured at billing api \nError ":err});
      throw ({"Error occured at billing api \nError ":err});
    }
  });
  
  // ... (remaining code)  
  

app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});
