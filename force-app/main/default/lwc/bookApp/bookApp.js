import { LightningElement } from 'lwc';
const BOOK_URL = 'https://www.googleapis.com/books/v1/volumes?q='
export default class BookApp extends LightningElement {
    query = 'Man'
    books
    timer

    connectedCallback(){
        this.fetchHookData()
    }

    fetchHookData(){
        fetch(BOOK_URL+this.query)
        .then(response => response.json())
        .then(data => {
            this.books = data
            console.log(this.books)
        })
        .catch(error => console.log(error))
    }

    getThumbnailUrl(book) {
        return book.volumeInfo.imageLinks ? book.volumeInfo.imageLinks.smallThumbnail : '';
    }

    fetchBooksHandler(event){
        this.query = event.target.value
        window.clearTimeout(this.timer)
        this.timer = setTimeout(() => {
            this.fetchHookData()
        }, 1000);
    }
}