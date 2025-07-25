import { LightningElement } from 'lwc';

export default class QuizApp extends LightningElement {
    selected={}
    
    correctAnswers = 0;
    isSubmited = false;

    myQuestions=[
        {
            id:'Question1',
            question:'Which one of the following is not a template loop?',
            answers:{
                a:'for:each',
                b:'iterator',
                c:'map loop'
            },
            correctAnswer:'c'
        },
        {
            id:'Question2',
            question:'Which file is an invalid component in LWC?',
            answers:{
                a:'.svg',
                b:'.apex',
                c:'.js'
            },
            correctAnswer:'b'
        },
        {
            id:'Question3',
            question:'Which one of the following is not a directive?',
            answers:{
                a:'for:each',
                b:'iterator',
                c:'@track'
            },
            correctAnswer:'c'
        }
    ]

    get allNotSelected(){
        return !(Object.keys(this.selected).length === this.myQuestions.length)
    }

    get isScoredFull(){
        return `slds-text-heading_large ${this.myQuestions.length === this.correctAnswers ? 'slds-text-color_success' : 'slds-text-color_error'}`
    }
   
    changeHandler(event){
        console.log("Name : ",event.target.name)
        console.log("Value : ",event.target.value)

        const {name,value} = event.target

        this.selected = {...this.selected, [name]:value }
    }

    submitHandler(event){
        event.preventDefault()

        let correct = this.myQuestions.filter(item => this.selected[item.id] === item.correctAnswer)
        this.correctAnswers = correct.length
        this.isSubmited = true
        console.log(this.correctAnswers)

    }

    resetHandler(){
        this.selected = {}
        this.correctAnswers = 0;
        this.isSubmited = false;
    }
}