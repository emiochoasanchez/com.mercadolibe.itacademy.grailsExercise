<html>
<head>
    <meta name="layout" content="main"/>
    <title>Welcome to Grails</title>
    <script src="https://unpkg.com/vue/dist/vue.min.js"></script>
    <script src="https://unpkg.com/axios/dist/axios.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
</head>
<body>

<select id="select" name="select" onchange="category.fetchData(this.value)">
    <g:each in ="${sites}" var="site">
        <option value="${site?.id}">${site.name} </option>
    </g:each>
</select>

<div id="category">
    <table border="1">
        <thead>
        <tr>
            <td>id</td>
            <td>Category</td>
        </tr>
        </thead>
        <tr v-for="category in categories">
            <td><a href="#"@click = "obtenerid(category.id)">{{ category.id }}</a></td>
            <td>{{category.name}}</td>
        </tr>
    </table>

    <!-- Modal -->
    <div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog modal-sm">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title">ARTICULO</h4>
                </div>
                <div class="modal-body">
                    <div class="text-center">
                    <h3> ID </h3>
                    <p>{{ category.finalcategory.id }}</p>
                    <h3> NAME </h3>
                    <p>{{ category.finalcategory.name }}</p>
                    <h3> IMAGEN </h3>
                    <img id="img" width="50" height="50">
                    <h3> ITEMS </h3>
                    <p>{{ category.finalcategory.total_items_in_this_category }}.</p>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                </div>
            </div>

        </div>
    </div>

</div>
<!--
    <div id="myModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <h3> ID </h3>
                <p>{{ category.finalcategory.id }}</p>
                <h3> NAME </h3>
                <p>{{ category.finalcategory.name }}</p>
                <h3> IMAGEN </h3>
                <img id="img" width="50" height="50">
                <h3> ITEMS </h3>
                <p>{{ category.finalcategory.total_items_in_this_category }}.</p>
            </div>
        </div>

    </div>
    -->


<script>

        var category = new Vue({
            el: '#category',
            data: {
                categories: category,
                finalcategory : [],
                bArt:""
            },
            methods: {
                fetchData: function (idSite) {
                    axios.get('/excercise/catSites', {
                        params:{
                            id:idSite
                        }
                    }).then(function (response) {
                        category.categories = response.data.categories;
                    }).catch(function (error) {
                        console.log(error);
                    })


                },

                fetchDataSub: function (idCat) {
                    axios.get('/excercise/subcatSites', {
                        params:{
                            id:idCat
                        }
                    }).then(function (response) {
                        category.categories = response.data.subcategories.children_categories;
                        if (category.categories.length==0) {

                            category.finalcategory = response.data.subcategories;
                             category.bArt=response.data.subcategories.id

                                document.getElementById("img").src = category.finalcategory.picture;
                           // $('#myModal').modal('show')
                            showModal();

                        }
                    }).catch(function (error) {
                        console.log(error);
                    })


                },

                borrar : function () {
                    axios.delete(

                    )

                }
            }



        })


        function obtenerid(id){
            category.fetchDataSub(id);
        }

        function showModal() {
            $(document).ready(function(){
                // Show the Modal on load
                category.bArt=

                $("#myModal").modal("show");
                // Hide the Modal
                $("#myBtn").click(function(){
                    $("#myModal").modal("hide");
                });
            });
        }





</script>
</body>
</html>>