const puppeteer = require('puppeteer');

(async () => {
    try {
        /* let cimri;
        
        const readline = require('readline').createInterface({
            input: process.stdin,
          });
          
          readline.question('Item: ', inpud => {
            cimri = inpud;
            readline.close();
          });
        */



        let browser = await puppeteer.launch();
        let page = await browser.newPage();
        await page.goto("https://www.cimri.com/dizustu-bilgisayar?page=1&sort=rank%2Cdesc"), { waitUntil: 'networkidle2' };

        let data = await page.evaluate(() => {
            let itemArray = [];
            let items = document.querySelectorAll("#cimri-product");
            items.forEach(function (item) {
                let title = item.querySelector('.product-title').getAttribute('title');
                let price = item.querySelector('.s14oa9nh-0 fFCyge');
                let link = "https://www.cimri.com" + item.querySelector('.link-detail').getAttribute('href');
                itemArray.push({ "title": title, "price": price, "link": link });
            });
            console.log("loop completed");
            return itemArray;
        });


        console.log(data);
        browser.close
        return data;
        

    } catch (e) {
        console.log(e);
    }
})();