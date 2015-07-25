OrderController =
  create: (req, res) ->

    # 1. 透過 Productid 找到 model product
    # 2. 檢查 user 是否存在，若否進行建立
    # 3. 建立訂單 order

    order = {
      id: '11223344'
      quantity: 10

      user: {
        username: 'test'
        email: 'test@gmail.com'
        mobile: '0911-111-111'
        address: '台灣省台灣市台灣路'
      }

      product: {
        name: '柚子'
        descript: '又大又好吃'
        stockQuantity: 10
        price: 100
        id: 1
      }
    }

    success = true

    res.ok {
      order: order
      success: success
    }
  status:  (req, res) ->
    console.log req.body.orderId
    console.log req.body.email

    db.User.findOne(
      where:
        email:req.body.email
    )
    .then (userData) ->
      return res.ok {msg: '沒有此User' } if userData is null

      db.Order.findOne(
        where:
          orderId:req.body.orderId
          UserId:userData.id
      )
      .then (orderProduct) ->
        if orderProduct?
          order = {
              id: orderProduct.orderId
              quantity: orderProduct.quantity
              user: {
                username: userData.username
                email: userData.email
                mobile: userData.mobile
                address: userData.address
              }
            }
          res.ok { order : order }
        else
          #沒有此訂單編號時在這處理
          res.ok { msg: '沒有此訂單' }


module.exports = OrderController
