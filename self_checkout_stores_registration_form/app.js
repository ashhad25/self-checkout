(() => {
    const storeName = document.getElementById('store-name-field');
    const storeLoc = document.getElementById('store-loc-field');
    const getURL = document.getElementById('get-api-field');
    const postURL = document.getElementById('post-api-field');
    const saveBtn = document.getElementById('save-store-btn');

    const addStoreURL = 'http://localhost:8000/api/storeRoute/addStore';

    const saveStore = async (e) => {
        // e.preventDefault();
        try {
            const body = {
                storename: storeName.value,
                latlng: storeLoc.value,
                getapi: getURL.value,
                postapi: postURL.value,
                addedby: 0
            };

            const response = await fetch(addStoreURL, {
                method: "POST",
                body: JSON.stringify(body),
                headers: {
                    "Content-Type": "application/json"
                }
            });
            if (response.status != 200) {
                alert('Store already registered with these coordinates.');
            }else{
                alert('Store registered successfully.');
                location.reload();
            }
            
        } catch (e) {
            console.log(e);
        }
    };

    saveBtn.addEventListener('click', saveStore); 
})();
