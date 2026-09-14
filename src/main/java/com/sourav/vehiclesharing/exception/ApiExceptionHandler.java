package com.sourav.vehiclesharing.exception;
import org.springframework.http.*; import org.springframework.web.bind.MethodArgumentNotValidException; import org.springframework.web.bind.annotation.*; import java.util.*;
@RestControllerAdvice public class ApiExceptionHandler { @ExceptionHandler(IllegalArgumentException.class) ResponseEntity<Map<String,String>> bad(IllegalArgumentException e){return ResponseEntity.badRequest().body(Map.of("error",e.getMessage()));}
 @ExceptionHandler(MethodArgumentNotValidException.class) ResponseEntity<Map<String,String>> validation(MethodArgumentNotValidException e){Map<String,String> m=new LinkedHashMap<>();e.getBindingResult().getFieldErrors().forEach(x->m.put(x.getField(),x.getDefaultMessage()));return ResponseEntity.badRequest().body(m);} }
