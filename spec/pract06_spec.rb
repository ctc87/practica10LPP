require "./lib/pract06"
include Practica7

describe Referencias do
	before :each do
			
		@ref1 = Libro.new(['autor1','autor2'], 'titulo', 'editorial', '1', '24/07/1990', ['ISBN-13: 978-1937785499', 'ISBN-10: 1937785491'], 'serie') 
		@ref2 = Libro.new(['Dave Thomas','Andy Hunt', 'Chad Fowler'], 'Programming Ruby 1.9 & 2.0: The Pragmatic Programmers Guide', 'Pragmatic Bookshelf', '4', '07/07/2013', ['ISBN-13: 978-1937785499', 'ISBN-10: 1937785491'], 'The Facets of Ruby') 
		@ref3 = Libro.new(['autor1','autor2'], 'titulo', 'editorial', '1', '25/08/1999', ['ISBN-13: 978-1937785499', 'ISBN-10: 1937785491']) 
 		@nod1 = Nodo.new(@ref1, nil, nil)
		@nod2 = Nodo.new(@ref2, nil, nil)
		@nod3 = Nodo.new(@ref3, nil, nil)
		@listVacia = Lista.new()	
		@listConContenido = Lista.new(@nod1)		
                @refp1 = Libro.new(['Dave Thomas','Andy Hunt', 'Chad Fowler'], 'Programming Ruby 1.9 & 2.0: The Pragmatic Programmers Guide', 'Pragmatic Bookshelf', '4', '07/07/2013', ['ISBN-13: 978-1937785499', 'ISBN-10: 1937785491'], 'The Facets of Ruby')

                @refp2 = Libro.new(['Scott Chacon'], 'Pro Git 2009th Edition', 'Apress', '2009', '27/08/2009', ['ISBN-13: 978-1430218333', 'ISBN-10: 1430218339'], 'Pro')

                @refp3 = Libro.new(['David Flanagan,','Yukihiro Matsumoto'], 'The Ruby Programming Language', 'O Reilly Media', '1', '04/02/2008', ['ISBN-10: 0596516177', 'ISBN-13: 978-0596516178'])

                @refp4 = Libro.new(['David Chelimsky','Dave Astels', 'Bryan Helmkamp', 'Dan North', 'Zach Dennis', 'Aslak Hellesoy'], 'The RSpecBook: Behaviour Driven Development with RSpec, Cucumber, and Friends', 'Pragmatic Bookshelf', '1', '25/12/2010', ['ISBN-10: 1934356379', 'ISBN-13: 978-1934356371'], 'The Facets of Ruby')

                @refp5 = Libro.new(['Richard E'], 'Silverman Git Pocket Guide', 'O Reilly Media', '1', '02/08/2013', ['ISBN-10: 1449325866', 'ISBN-13: 978-1449325862'])
                @nodp1 = Nodo.new(@refp1, nil, nil)
                @nodp2 = Nodo.new(@refp2, nil, nil)
                @nodp3 = Nodo.new(@refp3, nil, nil)
                @nodp4 = Nodo.new(@refp4, nil, nil)
                @nodp5 = Nodo.new(@refp5, nil, nil)
                @listaEnlazada = Lista.new(nil)
		
		# parte de la herencia
		@articuloRevista = ArticuloRevista.new(["Anonimo"],"ESCUELAS TALLER, CASAS DE OFICIOS Y TALLERES DE EMPLEO DE LA COMUNIDAD VALENCIANA", '01/05/2006', [24, 25], "Formacion y empleo", 'Camara')
 		@articuloPeriodico = ArticuloPeriodico.new(["Alvaro Torres"],"la cantinela del sin sentido", '02/07/2010', [35, 36], "Internacional", 'EL PAIS')
		@documentoElectronico = DocumentoElectronico.new(["Pablo Ramos", "Enrique Sevilla"], "El sobrepero", "09/08/2010", "www.articuloejemplo.com/el&sobrepeso")
		
	end  
	
	describe "Nodo para la lista enlazada"	do
		it "Debe existir un nodo con su dato y referencia al siguiente nodo apuntando a nil y su referencia al anterior nodo apuntando a nil tambien" do
			expect(@nod1.dato).to eq(@ref1)
			expect(@nod1.nodoAnterior).to eq(nil)
			expect(@nod1.nodoSiguiente).to eq(nil)
		end
	end
 
        describe "Lista enlazada creacion y comprobaciones"  do

		it "Debe existir un metodo que compruebe si la lista esta vacia" do
			expect(@listVacia.vacia).to eq(true)
			expect(@listConContenido.vacia).to eq(false) 	
		end		

        	it "Debe existir una lista enlazada con su cabeza o vacia " do
                        expect(@listVacia.cabeza).to eq (nil)
                        expect(@listConContenido.cabeza).to eq (@nod1)
                end
		it "Debe exisitir un contador de nodos que idique la medida de la lista" do
			expect(@listConContenido.contadorNodos).to eq(1)
			expect(@listVacia.contadorNodos).to eq(0)
		end
        end

	describe "Metodos de manejo de la lista enlazada" do
		it "Debe existir un metodo ultimo que acceda al final de la lista" do
			expect(@listConContenido.ultimo).to eq(@nod1)
		end
		
		it "Debe existir un metodo que permita insertar al final de una lsita vacia" do
			@listVacia.insertarFinal(@nod2)
			expect(@listVacia.cabeza).to eq(@nod2)
			expect(@listVacia.ultimo).to eq(@nod2)
			expect(@listVacia.contadorNodos).to eq(1)
			
		end
		
		it "Debe existir un metodo que inserte al final de la lista" do
			@listConContenido.insertarFinal(@nod2)
			expect(@listConContenido.cabeza).to eq(@nod1)
			@listConContenido.insertarFinal(@nod3)
			expect(@listConContenido.ultimo).to eq(@nod3)
			expect(@listConContenido.cabeza).to eq(@nod1)
			expect(@listConContenido.cabeza).to eq(@nod1)
			expect(@listConContenido.cabeza.nodoSiguiente).to eq(@nod2)
			expect(@listConContenido.cabeza.nodoSiguiente.nodoSiguiente).to eq(@nod3)
			expect(@listConContenido.cabeza.nodoSiguiente.nodoAnterior).to eq(@nod1)
			expect(@listConContenido.ultimo.nodoAnterior).to eq(@nod2)
			expect(@listConContenido.contadorNodos).to eq(3)
		end
		it "Debe existir un metodo para extraer el final de la lista" do
			expect(@listVacia.extraerUltimo).to eq(nil)
                        @listConContenido.insertarFinal(@nod2)
			@listConContenido.insertarFinal(@nod3)
			expect(@listConContenido.contadorNodos).to eq(3)
			expect(@listConContenido.extraerUltimo).to eq(@nod3)
			expect(@listConContenido.cabeza).to eq(@nod1)
			expect(@listConContenido.cabeza.nodoSiguiente).to eq(@nod2)
			expect(@listConContenido.ultimo).to eq(@nod2)
			expect(@listConContenido.ultimo.nodoAnterior).to eq(@nod1)
			expect(@listConContenido.ultimo.nodoSiguiente).to eq(nil)
			expect(@listConContenido.contadorNodos).to eq(2)
			
		end
		it "Debe existir un metodo para insertar en el inicio de la lista" do
			expect(@listConContenido.cabeza).to eq(@nod1)
			@listConContenido.insertarInicio(@nod2)
			expect(@listConContenido.cabeza).to eq(@nod2)
			expect(@listConContenido.ultimo).to eq(@nod1)
			expect(@listConContenido.ultimo.nodoAnterior).to eq(@nod2)
			expect(@listConContenido.contadorNodos).to eq(2)
		end
		it "Debe existir un metodo que permita insertar un nodo al principio de una lista vacia" do		
			@listVacia.insertarInicio(@nod2)
			expect(@listVacia.cabeza).to eq(@nod2)
			expect(@listVacia.ultimo).to eq(@nod2)
			expect(@listVacia.contadorNodos).to eq(1)
			
		end
		
		it "Debe existir un metodo para extraer el primer nodo de la lista" do
			expect(@listVacia.extraerCabeza).to eq(nil)
                        @listConContenido.insertarFinal(@nod2)
			@listConContenido.insertarFinal(@nod3)
			expect(@listConContenido.contadorNodos).to eq(3)
			expect(@listConContenido.extraerCabeza).to eq(@nod1)
			expect(@listConContenido.cabeza).to eq(@nod2)
			expect(@listConContenido.cabeza.nodoAnterior).to eq(nil)
			expect(@listConContenido.cabeza.nodoSiguiente).to eq(@nod3)
			expect(@listConContenido.ultimo).to eq(@nod3)
			expect(@listConContenido.contadorNodos).to eq(2)
			
		end
		
		it "Debe existir un metodo para borrar la lista" do
                        @listConContenido.insertarFinal(@nod2)
			expect(@listConContenido.cabeza.nodoAnterior).to eq(nil)
			expect(@listConContenido.cabeza.nodoSiguiente).to eq(@nod2)
			expect(@listConContenido.ultimo.nodoAnterior).to eq(@nod1)
			expect(@listConContenido.ultimo.nodoSiguiente).to eq(nil)
                        @listConContenido.insertarFinal(@nod3)
			expect(@listConContenido.cabeza.nodoAnterior).to eq(nil)
			@listConContenido.borrar
			expect(@listConContenido.vacia).to eq(true)
			expect(@listConContenido.contadorNodos).to eq(0)
		end

	end 

	
	describe "Almacenamiento de las referencias de un libro con la clase libro"  do
		it "Debe existir uno o mas autores y un metodo para acceder a ellos" do
			
			expect(@ref1.autor.length).to be > 1
			expect(@ref1.autor[0]).to eq('autor1') 
			expect(@ref1.autor[1]).to eq('autor2') 
		end
		
		it "Debe existir un titulo y un metodo para acceder a el" do
			expect(@ref1.titulo).to eq('titulo')		
		end
		
		it "Debe existir o no serie y un metodo para acceder a ella (si no existe se pondra como null)" do
			expect(@ref1.serie).to eq('serie')		
			expect(@ref3.serie).to eq('null')		
		end
		
		
		it "Debe existir un numero de edicion y un metodo para acceder a el" do
			expect(@ref1.numEdicion).to eq('1')
		end
		it "Debe existir una fecha de lanzamiento y un metodo para acceder a ella" do
			expect(@ref1.fechaDate).to be_an_instance_of(Date)
		end
		
		it "Debe existir una fechaDate de tipo fecha y un metodo para acceder a ella" do
			expect(@ref1.fecha).to eq('24/07/1990')
		end
		
		it "Debe existir uno o mas codigos ISBN y un metodo para acceder a ellos" do
			expect(@ref1.codISBN.length).to be > 1
			expect(@ref1.codISBN[0]).to eq('ISBN-13: 978-1937785499')
			expect(@ref1.codISBN[1]).to eq('ISBN-10: 1937785491')
		end
	end
        describe "Deben exsistir los siguientes metodos para visualizar el contenido"  do
                it  "Debe existir un metodo que imprima los autores" do

                        expect(@ref1.autorPrint()).to eq("autor1, autor2.")
		end
		it "Debe existir un metodo que imprima los codigos ISBN" do
			expect(@ref1.codISBNprint()).to eq("ISBN-13: 978-1937785499\nISBN-10: 1937785491")

		end
		it "Debe existir un metodo que imprima la fecha formateada" do
			expect(@ref1.fechaFormateada()).to eq("July 24, 1990")
		end
		it "Debe existir un metodo para obtener la referencia completa formateada con o sin serie" do
			expect(@ref1.salidaFormateada()).to eq("autor1, autor2.\ntitulo\n(serie)\neditorial; 1 edition (July 24, 1990)\nISBN-13: 978-1937785499\nISBN-10: 1937785491")
			expect(@ref2.salidaFormateada()).to eq("Dave Thomas, Andy Hunt, Chad Fowler.\nProgramming Ruby 1.9 & 2.0: The Pragmatic Programmers Guide\n(The Facets of Ruby)\nPragmatic Bookshelf; 4 edition (July 7, 2013)\nISBN-13: 978-1937785499\nISBN-10: 1937785491")
			expect(@ref3.salidaFormateada()).to eq("autor1, autor2.\ntitulo\neditorial; 1 edition (August 25, 1999)\nISBN-13: 978-1937785499\nISBN-10: 1937785491")
		end
	end
	
	describe "Pruebas con varias referencias " do
		it "Deberia poderse insertar todas las referencias en la lista por la cabeza y por el final y despues borrarlas" do
			@listaEnlazada.insertarInicio(@nodp1)		
			@listaEnlazada.insertarFinal(@nodp2)		
			@listaEnlazada.insertarFinal(@nodp3)
			expect(@listaEnlazada.contadorNodos).to eq(3)
			expect(@listaEnlazada.cabeza).to eq(@nodp1)		
			expect(@listaEnlazada.ultimo).to eq(@nodp3)		
			@listaEnlazada.insertarFinal(@nodp4)		
			expect(@listaEnlazada.contadorNodos).to eq(4)
			@listaEnlazada.insertarInicio(@nodp5)
			expect(@listaEnlazada.contadorNodos).to eq(5)
			expect(@listaEnlazada.cabeza).to eq(@nodp5)		
			expect(@listaEnlazada.ultimo).to eq(@nodp4)
			expect(@listaEnlazada.extraerCabeza).to eq(@nodp5)
			expect(@listaEnlazada.contadorNodos).to eq(4)
			expect(@listaEnlazada.extraerUltimo).to eq(@nodp4)		
			expect(@listaEnlazada.contadorNodos).to eq(3)
			expect(@listaEnlazada.cabeza).to eq(@nodp1)		
			expect(@listaEnlazada.ultimo).to eq(@nodp3)
			@listaEnlazada.borrar
			expect(@listaEnlazada.contadorNodos).to eq(0)
			expect(@listaEnlazada.vacia).to eq(true)
			expect(@listaEnlazada.cabeza).to eq(nil)		
			expect(@listaEnlazada.ultimo).to eq(nil)
					
		end
	end

        describe "Almacenamiento de las referencias de la clase ArticuloRevista " do
                it "Deberia existir un articulo de revista con su titulo, fecha, autor, paginas, seccion y revista y los metodos para acceder a estos" do
			expect(@articuloRevista.titulo).to eq("ESCUELAS TALLER, CASAS DE OFICIOS Y TALLERES DE EMPLEO DE LA COMUNIDAD VALENCIANA")
			expect(@articuloRevista.fecha).to eq('01/05/2006')
			expect(@articuloRevista.autor[0]).to eq('Anonimo')
			expect(@articuloRevista.paginas[0]).to eq(24)
			expect(@articuloRevista.paginas[1]).to eq(25)
			expect(@articuloRevista.revista).to eq('Camara')
			expect(@articuloRevista.seccion).to eq('Formacion y empleo')
		end
		it "Deeberia existir un metodo para obtener la salida formateada" do
			expect(@articuloRevista.salidaFormateada).to eq("CamaraAnonimo.\nESCUELAS TALLER, CASAS DE OFICIOS Y TALLERES DE EMPLEO DE LA COMUNIDAD VALENCIANA\npaginas:24, 25.; seccion: Formacion y empleo (May 1, 2006)\n")
		end	
        end

        describe "Almacenamiento de las referencias de la clase articuloaPeriodico " do
                it "Deberia existir un articulo de Periodico con su titulo, fecha, autor, paginas, seccion periodico y los metodos para acceder a estos" do
                        expect(@articuloPeriodico.titulo).to eq("la cantinela del sin sentido")
                        expect(@articuloPeriodico.fecha).to eq('02/07/2010')
                        expect(@articuloPeriodico.autor[0]).to eq('Alvaro Torres')
                        expect(@articuloPeriodico.paginas[0]).to eq(35)
                        expect(@articuloPeriodico.paginas[1]).to eq(36)
                        expect(@articuloPeriodico.periodico).to eq('EL PAIS')
                        expect(@articuloPeriodico.seccion).to eq('Internacional')
		end
		it "Deeberia existir un metodo para obtener la salida formateada" do
			expect(@articuloPeriodico.salidaFormateada).to eq("EL PAISAlvaro Torres.\nla cantinela del sin sentido\npaginas:35, 36.; seccion: Internacional (July 2, 2010)\n")
						
                end
        end

        describe "Almacenamiento de las referencias de la clase DocumentoElectronico" do
                it "Deberia existir un documento electronico con su titulo, su fecha, autor y link y los metodos para acceder a estos" do
                        expect(@documentoElectronico.titulo).to eq("El sobrepero")
                        expect(@documentoElectronico.fecha).to eq('09/08/2010')
                        expect(@documentoElectronico.autor[0]).to eq('Pablo Ramos')
                        expect(@documentoElectronico.autor[1]).to eq('Enrique Sevilla')
                        expect(@documentoElectronico.link).to eq('www.articuloejemplo.com/el&sobrepeso')

                end
                it "Deeberia existir un metodo para obtener la salida formateada" do
                        expect(@documentoElectronico.salidaFormateada).to eq("El sobrepero por Pablo Ramos, Enrique Sevilla.\nlink:www.articuloejemplo.com/el&sobrepeso\n (August 9, 2010)\n")

                end

        end

describe "Pruebas de pertencia a la jerarquia " do
                it "Documento electronico deberia ser un DocumentoElectronico y Referencias e instacia de DocumentoElectronico" do
			expect(@documentoElectronico.instance_of? DocumentoElectronico).to eq(true)
			expect(@documentoElectronico.instance_of? Referencias).to eq(false)
			expect(@documentoElectronico.is_a? DocumentoElectronico).to eq(true)
			expect(@documentoElectronico.is_a? Referencias).to eq(true)
				
		end
                it "Articulo periodico deberia ser un Articulo y un ArticuloPeriodico y una Referencia e instacia ArticuloPeriodico" do
                        expect(@articuloPeriodico.instance_of? ArticuloPeriodico).to eq(true)
                        expect(@articuloPeriodico.instance_of? Articulo).to eq(false)
                        expect(@articuloPeriodico.instance_of? Referencias).to eq(false)
                        expect(@articuloPeriodico.is_a? Referencias).to eq(true)
                        expect(@articuloPeriodico.is_a? Articulo).to eq(true)
                        expect(@articuloPeriodico.is_a? ArticuloPeriodico).to eq(true)

                end
                it "Articulo revista deberia ser un Articulo y un ArticuloRevista y una Referencia e instacia ArticuloRevista" do
                        expect(@articuloRevista.instance_of? ArticuloRevista).to eq(true)
                        expect(@articuloRevista.instance_of? Articulo).to eq(false)
                        expect(@articuloRevista.instance_of? Referencias).to eq(false)
                        expect(@articuloRevista.is_a? Referencias).to eq(true)
                        expect(@articuloRevista.is_a? Articulo).to eq(true)
                        expect(@articuloRevista.is_a? ArticuloRevista).to eq(true)

                end
                it "ref1 deberia ser un Libro y una Referencia y una instancia de libro" do
                        expect(@ref1.instance_of? Referencias).to eq(false)
                        expect(@ref1.instance_of? Libro).to eq(true)
                        expect(@ref1.is_a? Referencias).to eq(true)
                        expect(@ref1.is_a? Libro).to eq(true)

                end



        end

end
