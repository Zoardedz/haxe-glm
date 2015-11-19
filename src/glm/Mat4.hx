package glm;

/**
 * Utility class for dealing with 4x4 matrices
 */
abstract Mat4(Array<glm.Vec4>) {
	public function new(scale:Float = 0) {
		var arr:Array<glm.Vec4> = [
			new Vec4(scale, 0, 0, 0),
			new Vec4(0, scale, 0, 0),
			new Vec4(0, 0, scale, 0),
			new Vec4(0, 0, 0, scale)
		];
		this = arr;
		return cast this;
	}

	/**
	 * Construct a Mat4 from a series of Vec4s (representing rows)
	 * @param  rows<Vec4> the rows
	 * @return            a Mat4
	 */
	public static function fromRowArray(rows:Array<Vec4>):Mat4 {
		if(rows.length != 4) {
			throw "You must supply 4 Vec4s to build a Mat4 this way!";
		}
		var m:Mat4 = new Mat4();
		m[0] = rows[0];
		m[1] = rows[1];
		m[2] = rows[2];
		m[3] = rows[3];
		return m;
	}

	/**
	 * Construct a Mat4 from a series of Vec4s (representing rows)
	 * @param  a row 0
	 * @param  b row 1
	 * @param  c row 2
	 * @param  d row 3
	 * @return   a Mat4
	 */
	public static function fromRows(a:Vec4, b:Vec4, c:Vec4, d:Vec4):Mat4 {
		var m:Mat4 = new Mat4();
		m[0] = a;
		m[1] = b;
		m[2] = c;
		m[3] = d;
		return m;
	}

	/**
	 * Makes every element in `this` `=0`
	 * @return `this`
	 */
	public function zero():Mat4 {
		this[0].zero();
		this[1].zero();
		this[2].zero();
		this[3].zero();
		return cast this;
	}

	/**
	 * Creates a new Mat4 where the elements exactly equal the elements of `this`
	 */
	public function clone():Mat4 {
		var copy:Mat4 = new Mat4();
		copy[0] = this[0].clone();
		copy[1] = this[1].clone();
		copy[2] = this[2].clone();
		copy[3] = this[3].clone();
		return copy;
	}

	/**
	 * Makes `this` and identity matrix
	 * @return `this`
	 */
	public function identity():Mat4 {
		this[0].set(1, 0, 0, 0);
		this[1].set(0, 1, 0, 0);
		this[2].set(0, 0, 1, 0);
		this[3].set(0, 0, 0, 1);
		return cast this;
	}

	/**
	 * Provides array access in the form of `mat[i]` where `i ∈ [0, 1, 2, 3]`
	 * @return a `Vec4` representing the `i`th row
	 */
	@:arrayAccess public inline function arrayGet(i:Int):Vec4 {
		return this[i];
	}

	/**
	 * Provides array access in the form of `mat[i] = x` where `i ∈ [0, 1, 2, 3]`
	 * @return a `Vec4` representing the `i`th row (which has been set)
	 */
	@:arrayAccess public inline function arraySet(i:Int, x:Vec4):Vec4 {
		return this[i] = x;
	}

	/**
	 * Flattens `this` into [Row-major](https://en.wikipedia.org/wiki/Row-major_order) order
	 */
	public function toArrayRowMajor():Array<Float> {
		return this[0].toArray().concat(
			this[1].toArray().concat(
				this[2].toArray().concat(
					this[3].toArray()
				)
			)
		);
	}

	/**
	 * Flattens `this` into [Column-major](https://en.wikipedia.org/wiki/Column-major_order) order
	 */
	public function toArrayColMajor():Array<Float> {
		var ret:Array<Float> = new Array<Float>();
		for(j in 0...4) {
			for(i in 0...4) {
				ret.push(this[i][j]);
			}
		}
		return ret;
	}

	/**
	 * Multiplies `b` by `this`
	 * @param  b The vec4 to multiply by
	 * @return   `this` ✕ `b`
	 */
	public function multVec4(b:Vec4):Vec4 {
		return new Vec4(
			this[0][0] * b[0] + this[0][1] * b[1] + this[0][2] * b[2] + this[0][3] * b[3],
			this[1][0] * b[0] + this[1][1] * b[1] + this[1][2] * b[2] + this[1][3] * b[3],
			this[2][0] * b[0] + this[2][1] * b[1] + this[2][2] * b[2] + this[2][3] * b[3],
			this[3][0] * b[0] + this[3][1] * b[1] + this[3][2] * b[2] + this[3][3] * b[3]
		);
	}

	/**
	 * Allows multiplying matrices and vectors
	 */
	@:op(A * B)
	public static inline function multiplyVec4Op(a:Mat4, b:Vec4):Vec4 {
		return a.multVec4(b);
	}

	/**
	 * Multiplies `b` by `this`
	 * @param  b The mat4 to multiply by
	 * @return   `this` ✕ `b`
	 */
	public inline function multMat4(b:Mat4):Mat4 {
		var rows:Array<Vec4> = [
			this[0][0] * b[0] + this[0][1] * b[1] + this[0][2] * b[2] + this[0][3] * b[3],
			this[1][0] * b[0] + this[1][1] * b[1] + this[1][2] * b[2] + this[1][3] * b[3],
			this[2][0] * b[0] + this[2][1] * b[1] + this[2][2] * b[2] + this[2][3] * b[3],
			this[3][0] * b[0] + this[3][1] * b[1] + this[3][2] * b[2] + this[3][3] * b[3]
		];
		this = rows;
		return cast this;
	}

	/**
	 * Allows multiplying two matrices
	 */
	@:op(A * B)
	public static inline function multiplyMat4Op(a:Mat4, b:Mat4):Mat4 {
		return a.multMat4(b);
	}
}