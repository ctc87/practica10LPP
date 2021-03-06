require 'date'

# encoding: utf-8
# Este módulo se ha creado para describir
# distintas metodologías de programación
# haciendo uso del Lenguaje de Programación
# Ruby.  
# Con ella se han desarrollado los ejemplos
# de la asignatura Lenguajes y Paradigmas 
# de Programación.
#
# Author::    Carlos Troyano Carmona  (mailto:carlos@gmail.com)
# Copyright:: Cretive Commons
# License::   Distributes under the same terms as Ruby
#
module Practica7
  
  # Este struct es un nodo con un enlaze para una lista 
  # Enlazada que contendrá las referencias bibliograficas.

Nodo = Struct.new(:dato, :nodoSiguiente, :nodoAnterior) do
        include Comparable
        # Se define para incluir el mixin comparable
        # Se toma como valor para la comparación la fecha. 
        def <=>(other)
                self.fecha <=> other.fecha
        end

end

  # Este struct es una lista enlazada que almacena los nodos 
  # y que permite su manipulación
Lista = Struct.new(:cabeza,:contadorNodos) do
	# Constructor comprueba si tiene defuinido un nodo sigueinte y un nodo anterior o es nil (lista vacia)
	def initialize(cabeza=nil)
		if((defined? cabeza.nodoSiguiente) && (defined? cabeza.nodoAnterior))
			self.cabeza = cabeza
			self.contadorNodos = 1
		elsif(cabeza == nil)
			self.contadorNodos = 0
		else
			print "el parametro pasado ha de ser un nodo con siguiente y anterior"
		end
	end

	# Mixin enumerable que recorre las fechas de las referencias almacenadas en 
	# los nodos que componen la lista para ello sobrecargamos el método each
	include Enumerable
	def each
		size = self.contadorNodos - 1
        	aux = self.cabeza
        	for i in 0..size
			yield aux.dato.fechaDate
                	aux = aux.nodoSiguiente
        	end
  	end
	
	# Metodo que comprueba si está vacia
	def vacia
		vacia = cabeza == nil ? true : false 
	end

	# Metodo que borra la lsita enlazada
	def borrar
		while(!vacia)
			self.extraerCabeza
		end
	end

	# Metodo que devuelve el ultimo nodo de la lista
	def ultimo
		if(vacia)
			return nil
		end
		nodoActual = cabeza
		while(nodoActual.nodoSiguiente != nil)
			nodoActual = nodoActual.nodoSiguiente
		end
		return nodoActual
	end
	
	# Metodo que inserta un nodo en final de la lista
	def insertarFinal(nodo)
		if(vacia)
			self.cabeza = nodo
		else
			nodo.nodoAnterior = ultimo
			ultimo.nodoSiguiente = nodo
			 
		end 
		self.contadorNodos+=1  
	end
	
	# Metodo que inserta un nodo al principio de la lista
	def insertarInicio(nodo)
		if(vacia)
			self.cabeza = nodo 
		else
			aux = cabeza
			aux.nodoAnterior = nodo
			self.cabeza = nodo 
			self.cabeza.nodoSiguiente = aux
		end
		self.contadorNodos+=1  
	end
	
	# Metodo que extrae el ultimo nodo de la lista
	def extraerUltimo
		if(vacia)
			return nil
		end
		nodoActual = cabeza
		if(ultimo == cabeza)
			aux = cabeza
			cabeza = nil
			return aux
		end 
		while(nodoActual.nodoSiguiente.nodoSiguiente != nil)
			nodoActual = nodoActual.nodoSiguiente
		end	
		aux = nodoActual.nodoSiguiente
		nodoActual.nodoSiguiente = nil
		self.contadorNodos-=1  
		return aux 
	end
	
	# Metodo que extrae el primer nodo de la lista
	def extraerCabeza
		if(vacia)
			return nil
		end
		aux = cabeza
		self.cabeza = aux.nodoSiguiente
		if(defined? self.cabeza.nodoAnterior)
			self.cabeza.nodoAnterior = nil
		end
		self.contadorNodos-=1  
		return aux	
	end

	def to_s 
		 str = ""
		 size = self.contadorNodos - 1 
                 aux = self.cabeza
		 vector = []
        	 for i in 0..size
                        vector.push(extraerCabeza) 
                 end
		 vector.sort!{ |a,b| a.dato.getPrimerApellido <=> b.dato.getPrimerApellido }
		 for i in 0..size
			str += vector[i].dato.salidaFormateada + "\n"
		 end
		 str=str.sub(" y ", ' & ')
		 str = str.sub(" and ", " & ")
		 return str
	end
end

# Esta clase permite representar referncias bibliograficas aun que es una clase no 
# a crear objetos si no a la herencia sus atributos son:: 
# autor, titulo y fecha.
class Referencias
	# Acceso a los atributos de la clase geters y seters
	attr_reader :autor, :titulo, :fecha, :fechaDate, :letra, :countArray
	
	# Constructor que asigna los atributos pasados por parametro y formatea la fecha a un tipo de dato fecha
	def initialize(autor, titulo, fecha)
		@autor, @titulo, @fecha = autor, titulo, fecha
		@countArray = 0;           
                @letra = ("a".."z").to_a        
                 afecha = fecha.split(/\//)  
                 @fechaDate = Date.new(afecha[2].to_i, afecha[1].to_i, afecha[0].to_i)

	end
         # Metodo que imprime los autores formateados
         def autorPrint()
                 autores = ""
                 size = @autor.length - 1
                 for i in 0..size
                         if i != size
				 if @autor[i].split.size > 1
                                 	autores += "#{@autor[i].split[1]} #{@autor[i].split[0]}, "
				 else
                                 	autores += "#{@autor[i]}, "
				 end
                         else
				 if @autor[i].split.size > 1
                                 	autores += "#{@autor[i].split[1]} #{@autor[i].split[0]}."
                        	 else 
                                 	autores += "#{@autor[i]}."
				 end
			end
                 end
                 return autores
         end
 
         # Metodo que imprime la fecha formateada
         def fechaFormateada()
                 fechaFormateada = "#{@fechaDate.strftime("%B")} #{@fechaDate.mday}, #{@fechaDate.year}"
         end
	
	def getPrimerApellido 
		apellido = autor[0]
		if apellido.split.length > 1
			apellido = apellido.split[1]
		end
		return apellido
	end

	def getAnyo
		anyo = fecha.split("/")[2]
	end	
	
	def getTitulo
		str =""
		tituloSplited = titulo.split
		for i in 0..tituloSplited.length - 1
			str += tituloSplited[i].capitalize + " "	
		end
		return str		
	end
	include Comparable
        # Se define para incluir el mixin comparable
        # Se toma como valor para la comparación la fecha. 
        def <=>(other)
        	# Si los apellidos de los autores son iguales, se compara por el año
        	if self.getPrimerApellido != anOther.getPrimerApellido
         	   	self.getPrimerApellido <=> anOther.getPrimerApellido
        	else
			if(self.getAnyo != anOther.getAnyo)
            			self.getAnyo <=> anOther.getAnyo
			else
				self.fecha = self.fecha + self.letra[self.countArray]
				self.countArray++
				self.titulo <=> anOther.titulo
			end
        	end 
        end

end

# Esta clase permite representar referncias bibliograficas de documentos electronicos 
# destinada a crear objetos si no a la herencia, sus atributos son: 
# pagina, seccion.
class DocumentoElectronico < Referencias
	
	# Acceso a los atributos de la clase geters y seters
        attr_reader :link

        # Constructor que asigna los atributos pasados por parametro y formatea la fecha a un tipo de dato fecha
        def initialize(autor, titulo, fecha, link)
                @link = link
                super(autor, titulo, fecha)
        end

        # Metodo que imprime toda la referencia a un libro formateada
        def salidaFormateada()
                 salida = "#{self.getTitulo} por #{autorPrint()}\n\tlink:#{@link}\n\t (#{fechaFormateada()})\n"
        end
	

end



# Esta clase permite representar referncias bibliograficas de Articulos
# hereda de Referencias aun que es una clase no 
# destinada a crear objetos si no a la herencia, sus atributos son: 
# pagina, seccion.
class Articulo < Referencias
	# Acceso a los atributos de la clase geters y seters
	attr_reader :paginas, :seccion
	
	# Constructor que asigna los atributos pasados por parametro y formatea la fecha a un tipo de dato fecha
        def initialize(autor, titulo, fecha, paginas, seccion)
                @paginas, @seccion = paginas, seccion
                super(autor, titulo, fecha)
        end
   
	# Metodo que imprime los numeros de pagina
	def paginasPrint()
                 paginas = ""
                 size = @paginas.length - 1
                 for i in 0..size
                         if i != size
                                 paginas += "#{@paginas[i]}, "
                         else
                                 paginas += "#{@paginas[i]}."
                         end
                 end
                 return paginas
        end


end

# Esta clase permite representar referncias bibliograficas de Articulos
# de Periodico hereda de Articulos, sus atributos son: 
# periodico
class ArticuloPeriodico < Articulo
	# Acceso a los atributos de la clase geters y seters
         attr_reader :periodico
 
         # Constructor que asigna los atributos pasados por parametro 
         def initialize(autor, titulo, fecha, paginas, seccion, periodico)
                 @periodico = periodico
                 super(autor, titulo, fecha, paginas, seccion)
         end

	# Metodo que imprime toda la referencia a un libro formateada
	def salidaFormateada()
		salida = "#{@periodico}, #{autorPrint()}\n\t#{self.getTitulo}\n\tpaginas:#{paginasPrint()}; seccion: #{@seccion} (#{fechaFormateada()})\n"
        end
	

end

 # Esta clase permite representar referncias bibliograficas de Articulos
 # de revista hereda de Articulos, sus atributos son: 
 # revista
class ArticuloRevista < Articulo
        # Acceso a los atributos de la clase geters y seters
        attr_reader :revista 
        
	# Constructor que asigna los atributos pasados por parametro 
	def initialize(autor, titulo, fecha, paginas, seccion, revista)
                 @revista = revista
                 super(autor, titulo, fecha, paginas, seccion)
	end

        # Metodo que imprime toda la referencia a un libro formateada
        def salidaFormateada()
                salida = "#{@revista}#{autorPrint()}\n\t#{self.getTitulo}\n\tpaginas:#{paginasPrint()}; seccion: #{@seccion} (#{fechaFormateada()})\n"
        end
 
end


  # Esta clase permite representar referncias bibliograficas de libros con: 
  # autor, titulo, serie, editorial, edicion, fecha de lanzamiento, codigo ISBN.
class Libro < Referencias 
	# Acceso a los atributos de la clase geters y seters
	attr_reader :serie, :editorial, :numEdicion, :codISBN, :fechaDate
  	
	# Constructor que asigna los atributos pasados por parametro e invoca al
	# constructor del padre pasandole los parametros pertinentes 
	def initialize(autor, titulo, editorial, numEdicion, fecha, codISBN, serie = 'null')
		@serie, @editorial, @numEdicion, @codISBN = serie, editorial, numEdicion, codISBN 
		super(autor, titulo, fecha)
  	end
	
	# Metodo que imprime los codigos ISBN formateados
	def codISBNprint()
		listadoISBN = ""
		size = @codISBN.length - 1 
		for i in 0..size
			if i != size
				listadoISBN += "#{@codISBN[i]}\n\t"
			else
				listadoISBN += "#{@codISBN[i]}"
			end
		end
		return listadoISBN
	end

	# Metodo que imprime toda la referencia a un libro formateada
	def salidaFormateada()
		if @serie != "null"
			salida = "#{autorPrint()}\n\t#{self.getTitulo}\n\t(#{@serie})\n\t#{@editorial}; #{@numEdicion} edition (#{fechaFormateada()})\n\t#{codISBNprint()}"
		else
			salida = "#{autorPrint()}\n\t#{self.getTitulo}\n\t#{@editorial}; #{@numEdicion} edition (#{fechaFormateada()})\n\t#{codISBNprint()}"
			
		end
	end
end




end



