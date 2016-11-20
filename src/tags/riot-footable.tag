const riot = require('riot')
const moment = require('moment')

<riot-footable>
    <section>
        <input type="text" class="form-control input-sm m-b-xs" id="filter" placeholder="Search in table"/>
        <table class="footable table table-stripped footable" data-page-size="{opts.data.pagesize}" data-filter=#filter>
            <thead>
                <tr style="background-color: white;">
                    <th each={head,head_id in opts.data.headdata}  data-hide={(head_id > 2) ? 'phone':''}  class="footable-visible footable-sortable {head.class}">{head.label} <span class="footable-sort-indicator"></span></th>
                </tr>
            </thead>
            <tbody>
                <tr x-data-id="{tr._id}" class="gradeX trItem" id="trBooking1" each={tr,id in opts.data.tabledata} style="background-color: white;">
                    <td class="trigger text-center {(id =='1' || id =='2') ? 'data-hide':'' }" each={item,item_id in rowitems}> {get_final_prop(tr, item)}</td>
                    <td class="icons-box text-center" style="font-size: 1.2em;">
                        <a each={action in rowactions} x-data-id="{tr._id}"  onclick={action.onclick} class="action-link">
                            <span class="fa {action.iconclass} x-data-id="{tr._id}"  light-blue"></span>
                        </a>
                    </td>
                </tr>
            </tbody>
            <tfoot>
                <tr>
                    <td colspan="7" class="footable-visible">
                        <ul class="pagination pull-right"></ul>
                    </td>
                </tr>
            </tfoot>
        </table>
    </section>
    <script>
        
    	function query_to_state(store,collection_name,key_name, limit,criteria_json, fields_json){
		  let query_data = { query: true, criteria: criteria_json || {} , collection: collection_name}
		  this._.xhr(null, query_data).then((data) => {
		    store.setState('app', key_name, data.result)
		  })
		}



		const date = (date, format) => {
		    return moment(date).format(format);
		}

		function aggregate_to_state(store,collection_name,key_name, limit,criteria_json, fields_json){
		  let query_data = { query: true, criteria: criteria_json || {} , collection: collection_name}
		  this._.xhr(null, query_data).then((data) => {
		    store.setState('app', key_name, data.result)
		  })
		}


            this.identifier = 'common'

            this.get_final_prop  = (obj, key) => {
                if(key.format === 'currency'){
                    return  `$ ${this.get_prop(obj, key.value)}`
                } else if(key.format === 'date'){
                	debugger;
	            	return moment(this.get_prop(obj, key.value)).format(key.pattern)
                } else {
                    return this.get_prop(obj, key.value)
                }
            }

            this.get_prop = (obj, key) => {
                let arr = key.split('.')
                if(arr.length !== 1){
                    let left_key = key.replace(arr[0]+'.','') 
                    return this.get_prop(obj[arr[0]],left_key)
                } else {
                    return obj[key]
                }
            }

            this.on('mount', ()=>{
                this.rowitems = this.opts.data.rowitems
                this.rowactions = this.opts.data.rowactions
                this.update()
                $(this.opts.selector || '.footable').footable();
            })
    </script>
</riot-footable>