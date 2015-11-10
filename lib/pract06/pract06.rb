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

module Practica7
  
  # Este struct es un nodo con un enlaze para una lista 
  # Enlazada que contendrá las referencias bibliograficas.

Nodo = Struct.new(:dato, :nodoSiguiente) 

  # Este struct es una lista enlazada que almacena los nodos 
  # y que permite su manipulación
Lista = Struct.new(:cabeza) do
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
			ultimo.nodoSiguiente = nodo 
		end 
	end
	
	# Metodo que inserta un nodo al principio de la lista
	def insertarInicio(nodo)
		if(vacia)
			self.cabeza = nodo 
		else
			aux = cabeza
			self.cabeza = nodo 
			self.cabeza.nodoSiguiente = aux
		end	
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
		return aux 
	end
	
	# Metodo que extrae el primer nodo de la lista
	def extraerCabeza
		if(vacia)
			return nil
		end
		aux = cabeza
		self.cabeza = self.cabeza.nodoSiguiente
		return aux	
	end
end



  # Esta clase permite representar referncias bibliograficas de libros con: 
  # autor, titulo, serie, editorial, edicion, fecha de lanzamiento, codigo ISBN.
class Referencias
	
	# Acceso a los atributos de la clase geters y seters
	attr_reader :autor,:titulo, :serie, :editorial, :numEdicion, :fecha, :codISBN, :fechaDate
  	
	# Constructor que asigna los atributos pasados por parametro y formatea la fecha a un tipo de dato fecha
	def initialize(autor, titulo, editorial, numEdicion, fecha, codISBN, serie = 'null')
		@autor, @titulo, @serie, @editorial, @numEdicion, @codISBN, @fecha = autor, titulo, serie, editorial, numEdicion, codISBN, fecha 
		afecha = fecha.split(/\//)  
		@fechaDate = Date.new(afecha[2].to_i, afecha[1].to_i, afecha[0].to_i)
  	end
	
	# Metodo que imprime los autores formateados
	def autorPrint()
		autores = ""
		size = @autor.length - 1 
		for i in 0..size
			if i != size
				autores += "#{@autor[i]}, "
			else
				autores += "#{@autor[i]}."
			end
		end
		return autores
	end
	
	# Metodo que imprime la fecha formateada
	def fechaFormateada()
		fechaFormateada = "#{@fechaDate.strftime("%B")} #{@fechaDate.mday}, #{@fechaDate.year}"
	end
	
	# Metodo que imprime los codigos ISBN formateados
	def codISBNprint()
		listadoISBN = ""
		size = @codISBN.length - 1 
		for i in 0..size
			if i != size
				listadoISBN += "#{@codISBN[i]}\n"
			else
				listadoISBN += "#{@codISBN[i]}"
			end
		end
		return listadoISBN
	end

	# Metodo que imprime toda la referencia formateada
	def salidaFormateada()
		if @serie != "null"
			salida = "#{autorPrint()}\n#{@titulo}\n(#{@serie})\n#{@editorial}; #{@numEdicion} edition (#{fechaFormateada()})\n#{codISBNprint()}"
		else
			salida = "#{autorPrint()}\n#{@titulo}\n#{@editorial}; #{@numEdicion} edition (#{fechaFormateada()})\n#{codISBNprint()}"
			
		end
	end
end
end     
