const base_url = 'http://localhost';
const base_backend_url = '${base_url}:3000/';
const backend_product_endpoint = '${base_backend_url}products';
const backend_order_endpoint = '${base_backend_url}orders';
backend_billing_endpoint(int orderId) =>
    '${backend_order_endpoint}/$orderId/billing';
