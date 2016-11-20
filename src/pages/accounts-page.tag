require('../tags/riot-footable.tag')
<!-- require("../assets/css/footable/footable.core.css") -->

<accounts-page>
    <div class="row  border-bottom white-bg dashboard-header">
        <h2>Accounts</h2>
    </div>

    <div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-lg-12">
                <section id="accounts-table" x-data="accounts_data_owing"></section>
            </div>
        </div>
    </div>

    <script>
        
        this.action_one = (e) => {
            let id = e.target.closest('tr').getAttribute('x-data-id')
            alert('TODO :: to be implemented')
        }    

        this.action_two = (e) => {
            let id = e.target.closest('tr').getAttribute('x-data-id')
            alert('TODO :: to be implemented')
        }        

        const _data_my_accounts = [
        { 
            corp:{ name: 'Mike Gatting' },
            amount: '500',
            client:{ name: 'Andrew Slater' },
            due_date: new Date(),
            status: 'active'
        },
        { 
            corp:{ name: 'Ravish Kumar' },
            amount: '300',
            client:{ name: 'Arnab Goswami' },
            due_date: new Date(),
            status: 'active'
        },
        { 
            corp:{ name: 'Rohit Sardana' },
            amount: '1000',
            client:{ name: 'Sudhanshu Trivedi' },
            due_date: new Date(),
            status: 'active'
        }]

        this.on('mount', ()=>{
            // fetch related data of recent past
            setTimeout(()=>{
                let accounts_data_owing = {
                    pagesize:"2",
                    headdata:[
                        {class:"text-center", label:"Name"},
                        {class:"text-center", label:"Amount"},
                        {class:"text-center", label:"Client"},
                        {class:"text-center", label:"Due Date"},
                        {class:"text-center", label:"Status"},
                        {class:"text-center", label:"Actions"}
                    ],
                    tabledata: _data_my_accounts,
                    rowitems: [{value:'corp.name'},{value:'amount', format: 'currency'},{value:'client.name'},{value:'due_date', format: 'date', pattern: 'DD-MMM-YY' },{value:'status'}],
                    rowactions: [
                                {onclick:this.action_one,iconclass:"fa-envelope"},
                                {onclick:this.action_two,iconclass:"fa-eye"}
                            ]
                }
                riot.mount('section#accounts-table','riot-footable',{data:accounts_data_owing})
            },2000)// @todo remove this settimeout hack : once auto-update works  
        })
    </script>
</accounts-page>