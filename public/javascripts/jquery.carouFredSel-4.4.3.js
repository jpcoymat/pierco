/*	
 *	jQuery carouFredSel 4.4.3
 *	Demo's and documentation:
 *	caroufredsel.frebsite.nl
 *	
 *	Copyright (c) 2010 Fred Heusschen
 *	www.frebsite.nl
 *
 *	Dual licensed under the MIT and GPL licenses.
 *	http://en.wikipedia.org/wiki/MIT_License
 *	http://en.wikipedia.org/wiki/GNU_General_Public_License
 */

(function($) {
	if ($.fn.carouFredSel) return;

	$.fn.carouFredSel = function(o) {
		if (this.length == 0) {
			debug(true, 'No element found for "'+this.selector+'".');
			return this;
		}
		if (this.length > 1) {
			return this.each(function() {
				$(this).carouFredSel(o);
			});
		}

		var $cfs = this,
			$tt0 = this[0];

		$cfs.init = function(o, setOrig, start) {
			var obs = ['items', 'scroll', 'auto', 'prev', 'next', 'pagination'];
			o = getObject($tt0, o);
			for (var a = 0, l = obs.length; a < l; a++) {
				o[obs[a]] = getObject($tt0, o[obs[a]]);
			}
			if (typeof o.scroll == 'number') {
				if (o.scroll <= 50)					o.scroll	= { items		: o.scroll 	};
				else								o.scroll	= { duration	: o.scroll 	};
			} else {
				if (typeof o.scroll == 'string')	o.scroll	= { easing		: o.scroll 	};
			}
				 if (typeof o.items == 'number')	o.items		= { visible		: o.items 	};
			else if (		o.items == 'variable')	o.items		= { visible		: o.items,
																	width		: o.items, 
																	height		: o.items	};

			if (setOrig) opts_orig = $.extend(true, {}, $.fn.carouFredSel.defaults, o);

			opts = $.extend(true, {}, $.fn.carouFredSel.defaults, o);
			opts.d = {};
			opts.variableVisible = false;
			opts.visibleAdjust = false;

			if (opts.items.start == 0 && typeof start == 'number') {
				opts.items.start = start;
			}

			direction = (opts.direction == 'up' || opts.direction == 'left') ? 'next' : 'prev';

			var dims = [
				['width'	, 'innerWidth'	, 'outerWidth'	, 'height'	, 'innerHeight'	, 'outerHeight'	, 'left', 'top'	, 'marginRight'	, 0, 1, 2, 3],
				['height'	, 'innerHeight'	, 'outerHeight'	, 'width'	, 'innerWidth'	, 'outerWidth'	, 'top'	, 'left', 'marginBottom', 3, 2, 1, 0]
			];
			var dn = dims[0].length,
				dx = (opts.direction == 'right' || opts.direction == 'left') ? 0 : 1;

			for (var d = 0; d < dn; d++) {
				opts.d[dims[0][d]] = dims[dx][d];
			}

			var	all_itm = getItems($cfs),
				lrgst_b = getTrueLargestSize(all_itm, opts, 'outerHeight', false);


			//	DEPRECATED
			if (opts.padding == 'auto') {
				debug(true, 'The option "padding: auto" is deprecated, use "align: center".');
				opts.padding = false;
				opts.align = 'center';
			}
			//	/DEPRECATED


			//	secondairy size set to auto -> measure largest size and set it
			if (opts[opts.d['height']] == 'auto') {
				opts[opts.d['height']] = lrgst_b;
				opts.items[opts.d['height']] = lrgst_b;
			}

			//	primairy item-size not set -> measure it or set to "variable"
			if (!opts.items[opts.d['width']]) {
				opts.items[opts.d['width']] = (hasVariableSizes(all_itm, opts, 'outerWidth')) 
					? 'variable' 
					: all_itm[opts.d['outerWidth']](true);
			}

			//	secondairy item-size not set -> measure it or set to "variable"
			if (!opts.items[opts.d['height']]) {
				opts.items[opts.d['height']] = (hasVariableSizes(all_itm, opts, 'outerHeight')) 
					? 'variable' 
					: all_itm[opts.d['outerHeight']](true);
			}

			//	secondairy size not set -> set to secondairy item-size
			if (!opts[opts.d['height']]) {
				opts[opts.d['height']] = opts.items[opts.d['height']];
			}

			switch (opts.items.visible) {
				case '+1':
				case '-1':
				case 'odd':
				case 'odd+':
				case 'even':
				case 'even+':
					opts.visibleAdjust = opts.items.visible;
					opts.items.visible = false;
					break;
			}

			//	visible-items not set
			if (!opts.items.visible) {
				//	primairy item-size variable -> set visible items variable
				if (opts.items[opts.d['width']] == 'variable') {
					opts.items.visible = 'variable';
				} else {
					//	primairy size is number -> calculate visible-items
					if (typeof opts[opts.d['width']] == 'number') {
						opts.items.visible = Math.floor(opts[opts.d['width']] / opts.items[opts.d['width']]);
					} else {
						//	measure and calculate primairy size and visible-items
						var maxS = getTrueInnerSize($wrp.parent(), opts, 'innerWidth');
						opts.items.visible = Math.floor(maxS / opts.items[opts.d['width']]);
						opts[opts.d['width']] = opts.items.visible * opts.items[opts.d['width']];
						if (!opts.visibleAdjust) opts.align = false;
					}
					if (opts.items.visible == 'Infinity' ||	opts.items.visible < 0) {
						debug(true, 'Not a valid number of visible items: Set to "1".');
						opts.items.visible = 1;
					}

					opts.items.visible = getVisibleItemsAdjust(opts.items.visible, opts);
				}
			}

			//	primairy size not set -> calculate it or set to "variable"
			if (!opts[opts.d['width']]) {
				if (opts.items.visible != 'variable' && opts.items[opts.d['width']] != 'variable') {
					opts[opts.d['width']] = opts.items.visible * opts.items[opts.d['width']];
					opts.align = false;
				} else {
					opts[opts.d['width']] = 'variable';
				}
			}

			//	variable primairy item-sizes with variabe visible-items
			if (opts.items.visible == 'variable') {
				opts.variableVisible = true;
				opts.maxDimention = (opts[opts.d['width']] == 'variable')
					? getTrueInnerSize($wrp.parent(), opts, 'innerWidth')
					: opts[opts.d['width']];
				if (opts.align === false) {
					opts[opts.d['width']] = 'variable';
				}
				opts.items.visible = getVisibleItemsNext(all_itm, opts, 0);
			}

			if (typeof opts.padding == 'undefined') {
				opts.padding = 0;
			}

			//	align not set -> set to center if primairy size is number
			if (typeof opts.align == 'undefined') {
				opts.align = (opts[opts.d['width']] == 'variable')
					? false
					: 'center';
			}

			opts.items.oldVisible = opts.items.visible;
			opts.usePadding = false;
			opts.padding = getPadding(opts.padding);

			if (opts.align == 'top') 		opts.align = 'left';
			if (opts.align == 'bottom') 	opts.align = 'right';

			switch (opts.align) {
				//	align: center, left or right
				case 'center':
				case 'left':
				case 'right':
					if (opts[opts.d['width']] != 'variable') {
						var p = getAlignPadding(getCurrentItems(all_itm, opts), opts);
						opts.usePadding = true;
						opts.padding[opts.d[1]] = p[1];
						opts.padding[opts.d[3]] = p[0];
					}
					break;

				//	padding
				default:
					opts.align = false;
					opts.usePadding = (
						opts.padding[0] == 0 && 
						opts.padding[1] == 0 && 
						opts.padding[2] == 0 && 
						opts.padding[3] == 0
					) ? false : true;
					break;
			}

			if (typeof opts.items.minimum	!= 'number')	opts.items.minimum		= (opts.variableVisible) ? 1 : opts.items.visible;
			if (typeof opts.scroll.items	!= 'number')	opts.scroll.items		= (opts.variableVisible) ? 'variable' : opts.items.visible;
			if (typeof opts.scroll.duration	!= 'number')	opts.scroll.duration	= 500;

			opts.auto		= getNaviObject($tt0, opts.auto, false, true);
			opts.prev		= getNaviObject($tt0, opts.prev);
			opts.next		= getNaviObject($tt0, opts.next);
			opts.pagination	= getNaviObject($tt0, opts.pagination, true);

			opts.auto		= $.extend(true, {}, opts.scroll, opts.auto);
			opts.prev		= $.extend(true, {}, opts.scroll, opts.prev);
			opts.next		= $.extend(true, {}, opts.scroll, opts.next);
			opts.pagination	= $.extend(true, {}, opts.scroll, opts.pagination);

			if (typeof opts.pagination.keys				!= 'boolean')	opts.pagination.keys 			= false;
			if (typeof opts.pagination.anchorBuilder	!= 'function')	opts.pagination.anchorBuilder	= $.fn.carouFredSel.pageAnchorBuilder;
			if (typeof opts.auto.play					!= 'boolean')	opts.auto.play					= true;
			if (typeof opts.auto.nap					!= 'boolean')	opts.auto.nap					= true;
			if (typeof opts.auto.delay					!= 'number')	opts.auto.delay					= 0;
			if (typeof opts.auto.pauseDuration			!= 'number')	opts.auto.pauseDuration			= (opts.auto.duration < 10) ? 2500 : opts.auto.duration * 5;

			if (opts.synchronise) {
				opts.synchronise = getSynchArr(opts.synchronise);
			}
			if (opts.debug) {
				debug(true, 'Carousel width: '+opts.width);
				debug(true, 'Carousel height: '+opts.height);
				debug(true, 'Item widths: '+opts.items.width);
				debug(true, 'Item heights: '+opts.items.height);
				debug(true, 'Number of items visible: '+opts.items.visible);
				if (opts.auto.play)		debug(true, 'Number of items scrolled automatically: '+opts.auto.items);
				if (opts.prev.button)	debug(true, 'Number of items scrolled backward: '+opts.prev.items);
				if (opts.next.button)	debug(true, 'Number of items scrolled forward: '+opts.next.items);
			}
		};	//	/init

		$cfs.build = function() {
			if ($cfs.css('position') == 'absolute' || $cfs.css('position') == 'fixed') {
				debug(opts.debug, 'Carousels CSS-attribute "position" should be "static" or "relative".');
			}
			$wrp.css({
				position	: 'relative',
				overflow	: 'hidden',
				marginTop	: $cfs.css('marginTop'),
				marginRight	: $cfs.css('marginRight'),
				marginBottom: $cfs.css('marginBottom'),
				marginLeft	: $cfs.css('marginLeft')
			});
			$cfs.data('cfs_origCss', {
				width		: $cfs.css('width'),
				height		: $cfs.css('height'),
				marginTop	: $cfs.css('marginTop'),
				marginRight	: $cfs.css('marginRight'),
				marginBottom: $cfs.css('marginBottom'),
				marginLeft	: $cfs.css('marginLeft'),
				'float'		: $cfs.css('float'),
				position	: $cfs.css('position'),
				top			: $cfs.css('top'),
				left		: $cfs.css('left')
			}).css({
				marginTop	: 0,
				marginRight	: 0,
				marginBottom: 0,
				marginLeft	: 0,
				'float'		: 'none',
				position	: 'absolute'
			});
			if (opts.usePadding) {
				getItems($cfs).each(function() {
					var m = parseInt($(this).css(opts.d['marginRight']));
					if (isNaN(m)) m = 0;
					$(this).data('cfs_origCssMargin', m);
				});
			}
		};	//	/build

		$cfs.bind_events = function() {
			$cfs.unbind_events();

			$cfs.bind('stop.cfs'+serial, function(e) {
				e.stopPropagation();
				$cfs.trigger('pause');
				opts.auto.play = false;
				isPaused = 'stopped';
			});

			$cfs.bind('pause.cfs'+serial, function(e, g) {
				e.stopPropagation();

				//	DEPRECATED
				if (typeof g == 'boolean') {
					debug(true, 'Pause a carousel globally is deprecated, use the "stop" custom event.');
					$cfs.trigger('stop');
					return;
				}
				//	/DEPRECATED

				isPaused = true;

				if (autoTimeout != null)	clearTimeout(autoTimeout);
				if (autoInterval != null)	clearInterval(autoInterval);
				if (timerInterval != null)	clearInterval(timerInterval);

				var dur1 = opts.auto.pauseDuration - pauseTimePassed,
					perc = 100 - Math.ceil( dur1 * 100 / opts.auto.pauseDuration );

				if (perc != 0) {
					if (opts.auto.onPausePause) opts.auto.onPausePause.call($tt0, perc, dur1);
				}
			});

			$cfs.bind('play.cfs'+serial, function(e, dir, dla, sta) {
				e.stopPropagation();
				$cfs.trigger('pause');

				var v = [dir, dla, sta],
					t = ['string', 'number', 'boolean'],
					a = sortParams(v, t);

				var dir = a[0],
					dla = a[1],
					sta = a[2];

				if (dir != 'prev' && dir != 'next') dir = direction;
				if (typeof dla != 'number') 		dla = 0;

				if (sta) opts.auto.play = true;
				if (!opts.auto.play) {
					e.stopImmediatePropagation();
					return;
				}

				isPaused = false;

				var dur1 = opts.auto.pauseDuration - pauseTimePassed,
					dur2 = dur1 + dla;
					perc = 100 - Math.ceil(dur1 * 100 / opts.auto.pauseDuration);

				autoTimeout = setTimeout(function() {
					if ($cfs.is(':animated')) {
						$cfs.trigger('play', dir);
					} else {
						pauseTimePassed = 0;
						$cfs.trigger(dir, opts.auto);
					}
				}, dur2);

				if (opts.auto.pauseOnHover === 'resume') {
					autoInterval = setInterval(function() {
						pauseTimePassed += 50;
					}, 50);
				}
				if (opts.auto.onPauseEnd && perc == 0) {
					opts.auto.onPauseEnd.call($tt0, perc, dur1);
				}
				if (opts.auto.onPauseStart) {
					timerInterval = setTimeout(function() {
						opts.auto.onPauseStart.call($tt0, perc, dur1);
					}, dla);
				}
			});

			$cfs.bind('prev.cfs next.cfs'+serial, function(e, obj, num, clb) {
				e.stopPropagation();
				if (typeof force != 'boolean') force = false;

				if (isPaused == 'stopped' || $cfs.is(':hidden')) {
					return;
				}
				var v = [obj, num, clb],
					t = ['object', 'number', 'function'],
					a = sortParams(v, t);

				var obj = a[0],
					num = a[1],
					clb = a[2];

				if (typeof obj != 'object' || obj == null)			obj = opts[e.type];
				if (typeof clb == 'function')						obj.onAfter = clb;
				if (typeof num != 'number') {
						 if (typeof obj.items == 'number') 			num = obj.items;
					else if (typeof opts[e.type].items == 'number')	num = opts[e.type].items;
					else 											num = opts.items.visible;
				}

				if (obj.duration > 0) {
					if ($cfs.is(':animated')) {
						if (obj.queue) $cfs.trigger('queue', [e.type, [obj, num, clb]]);
						return;
					}
					if (opts.items.minimum >= totalItems) {
						debug(opts.debug, 'Not enough items: not scrolling.');
						return;
					}
				}
				pauseTimePassed = 0;

				if (typeof num != 'number') return debug(opts.debug, 'Not a valid number: '+num+'. Not scrolling');
				if (obj.conditions && !obj.conditions.call($tt0)) return debug(opts.debug, 'Callback "conditions" returned false.');

				$cfs.trigger('slide_'+e.type, [obj, num]);

				if (opts.synchronise) {
					var s = opts.synchronise;
					oI = num;
					for (var j = 0, l = s.length; j < l; j++) {
						var d = e.type;
						if (!s[j][1]) a[0] = s[j][0].triggerHandler('configuration', e.type);
						if (!s[j][2]) d = (d == 'prev') ? 'next' : 'prev';
						a[1] = oI + s[j][3];
						s[j][0].trigger('slide_'+d, a);
					}
				}
			});

			$cfs.bind('slide_prev.cfs'+serial, function(e, sO, nI) {
				e.stopPropagation();
				if (opts.variableVisible) {
					oI = nI;
					opts.items.oldVisible = opts.items.visible;
					var a_itm = getItems($cfs);
					if (opts.usePadding) resetMargin(a_itm, opts);
					opts.items.visible = getVisibleItemsPrev(a_itm, opts, oI);
					nI = opts.items.visible - opts.items.oldVisible + oI;
					if (nI <= 0) {
						opts.items.visible = getVisibleItemsNext(a_itm, opts, totalItems-oI);
						nI = oI;
					}
					if (opts.usePadding) resetMargin(a_itm, opts, true);
				}
				if (!opts.circular) {
					var nulItem = totalItems - firstItem;
					if (nulItem - nI < 0) {
						nI = nulItem;
					}
					if (firstItem == 0) {
						nI = 0;
					}
				}

				firstItem += nI;
				if (firstItem >= totalItems) firstItem -= totalItems;

				if (!opts.circular) {
					if (firstItem == 0 && nI != 0 && sO.onEnd) sO.onEnd.call($tt0);
					if (opts.infinite) {
						if (nI == 0) {
							$cfs.trigger('next', totalItems-opts.items.visible);
							return;
						}
					} else enableNavi(opts, firstItem);
				}

				if (nI == 0) {
					e.stopImmediatePropagation();
					return;
				}

				getItems($cfs).slice(totalItems-nI).prependTo($cfs);
				if (totalItems < opts.items.visible + nI) {
					getItems($cfs).slice(0, (opts.items.visible+nI)-totalItems).clone(true).appendTo($cfs);
				}

				var a_itm = getItems($cfs),
					c_old = getOldItemsPrev(a_itm, opts, nI),
					c_new = getNewItemsPrev(a_itm, opts),
					l_cur = a_itm.eq(nI-1),
					l_old = c_old.last(),
					l_new = c_new.last();

				if (opts.usePadding) {
					resetMargin(l_old, opts);
					resetMargin(c_new, opts);
				}

				if (opts.align) var p = getAlignPadding(c_new, opts);
				if (sO.fx == 'directscroll' && opts.items.oldVisible < nI) {
					var hiddenitems = a_itm.slice(opts.items.oldVisible, nI).hide(),
						orgW = opts.items[opts.d['width']];
					opts.items[opts.d['width']] = 'variable';
				} else {
					var hiddenitems = false;
				}

				var i_siz = getTotalSize(a_itm.slice(0, nI), opts, 'width'),
					w_siz = mapWrapperSizes(getSizes(c_new, opts, true), opts, !opts.usePadding);

				if (hiddenitems) {
					opts.items[opts.d['width']] = orgW;
				}
				if (opts.usePadding) {
					resetMargin(l_old, opts, opts.padding[opts.d[1]]);
					resetMargin(l_cur, opts, opts.padding[opts.d[3]]);
				}
				if (opts.align) {
					opts.padding[opts.d[1]] = p[1];
					opts.padding[opts.d[3]] = p[0];
				}
				var a_cfs = {},
					a_new = {},
					a_cur = {},
					a_old = {},
					a_dur = sO.duration;

					 if (sO.fx == 'none')	a_dur = 0;
				else if (a_dur == 'auto')	a_dur = opts.scroll.duration / opts.scroll.items * nI;
				else if (a_dur <= 0)		a_dur = 0;
				else if (a_dur < 10)		a_dur = i_siz / a_dur;

				var a_conf = {
					duration: a_dur,
					easing	: sO.easing
				};
				if (sO.onBefore) sO.onBefore.call($tt0, c_old, c_new, w_siz, a_dur);
				if (opts.usePadding) {
					var new_m = opts.padding[opts.d[3]];
					a_cur[opts.d['marginRight']] = l_cur.data('cfs_origCssMargin');
					a_new[opts.d['marginRight']] = l_new.data('cfs_origCssMargin') + opts.padding[opts.d[1]];
					a_old[opts.d['marginRight']] = l_old.data('cfs_origCssMargin');

					l_cur.stop().animate(a_cur, a_conf);
					l_new.stop().animate(a_new, a_conf);
					l_old.stop().animate(a_old, a_conf);

				} else {
					var new_m = 0;
				}
				a_cfs[opts.d['left']] = new_m;

				if (opts[opts.d['width']] == 'variable' || opts[opts.d['height']] == 'variable') {
					$wrp.stop().animate(w_siz, a_conf);
				}

				//	alternative effects
				switch(sO.fx) {
					case 'crossfade':
					case 'cover':
					case 'uncover':
						var $cf2 = $cfs.clone().appendTo($wrp);
						break;
				}
				switch(sO.fx) {
					case 'uncover':
						getItems($cf2).slice(0, nI).remove();
					case 'crossfade':
					case 'cover':
						getItems($cf2).slice(opts.items.visible).remove();
						break;
				}
				switch(sO.fx) {
					case 'fade':
						fx_fade(sO, $cfs, 0, a_dur);
						break;
					case 'crossfade':
						$cf2.css({ opacity: 0 });
						fx_fade(sO, $cf2, 1, a_dur);
						fx_fade(sO, $cfs, 1, a_dur, function() { $cf2.remove(); });
						break;
					case 'cover':
						fx_cover(sO, $cfs, $cf2, opts, a_dur, true);
						break;
					case 'uncover':
						fx_uncover(sO, $cfs, $cf2, opts, a_dur, true, nI);
						break;
				}
				switch(sO.fx) {
					case 'fade':
					case 'crossfade':
					case 'cover':
					case 'uncover':
						f_dur = a_dur;
						a_dur = 0;
						break;
				}
				//	/alternative effects

				var c_nI = nI;
				$cfs.css(opts.d['left'], -i_siz);
				$cfs.animate(a_cfs, {
					duration: a_dur,
					easing	: sO.easing,
					complete: function() {
						var overFill = opts.items.visible+c_nI-totalItems;
						if (overFill > 0) {
							getItems($cfs).slice(totalItems).remove();
							c_old = getItems($cfs).slice(totalItems-(c_nI-overFill)).get().concat( getItems($cfs).slice(0, overFill).get() );
						}
						if (hiddenitems) hiddenitems.show();
						if (opts.usePadding) {
							var l_itm = getItems($cfs).eq(opts.items.visible+c_nI-1);
							l_itm.css(opts.d['marginRight'], l_itm.data('cfs_origCssMargin'));
						}

						var fn = function() {
							if (sO.onAfter) {
								sO.onAfter.call($tt0, c_old, c_new, w_siz);
							}
							if (queue.length) {
								setTimeout(function() {
									$cfs.trigger(queue[0][0], queue[0][1]);
									queue.shift();
								}, 1);
							}
						};
						switch(sO.fx) {
							case 'fade':
							case 'uncover':
								fx_fade(sO, $cfs, 1, f_dur, fn);
								break;

							default:
								fn();
								break;
						}
					}
				});
				$cfs.trigger('updatePageStatus', [false, w_siz]).trigger('play', a_dur);
			});

			$cfs.bind('slide_next.cfs'+serial, function(e, sO, nI) {
				e.stopPropagation();
				if (opts.variableVisible) {
					opts.items.oldVisible = opts.items.visible;
					var a_itm = getItems($cfs);
					if (opts.usePadding) resetMargin(a_itm, opts);
					opts.items.visible = getVisibleItemsNext(a_itm, opts, nI);
					if (opts.items.oldVisible - nI >= opts.items.visible) opts.items.visible = getVisibleItemsNext(a_itm, opts, ++nI);
					if (opts.usePadding) resetMargin(a_itm, opts, true);
				}
				if (!opts.circular) {
					if (firstItem == 0) {
						if (nI > totalItems - opts.items.visible) {
							nI = totalItems - opts.items.visible;
						}
					} else {
						if (firstItem - nI < opts.items.visible) {
							nI = firstItem - opts.items.visible;
						}
					}
				}

				firstItem -= nI;
				if (firstItem < 0) firstItem += totalItems;

				if (!opts.circular) {
					if (firstItem == opts.items.visible && nI != 0 && sO.onEnd) sO.onEnd.call($tt0);
					if (opts.infinite) {
						if (nI == 0) {
							$cfs.trigger('prev', totalItems-opts.items.visible);
							return;
						}
					} else enableNavi(opts, firstItem);
				}

				if (nI == 0) return;					
				if (totalItems < opts.items.visible + nI) getItems($cfs).slice(0, (opts.items.visible+nI)-totalItems).clone(true).appendTo($cfs);

				var a_itm = getItems($cfs),
					c_old = getOldItemsNext(a_itm, opts),
					c_new = getNewItemsNext(a_itm, opts, nI),
					l_cur = c_old.eq(nI-1),
					l_old = c_old.last(),
					l_new = c_new.last();

				if (opts.usePadding) {
					resetMargin(l_old, opts);
					resetMargin(l_new, opts);
				}

				if (opts.align) var p = getAlignPadding(c_new, opts);
				if (sO.fx == 'directscroll' && opts.items.oldVisible < nI) {
					var hiddenitems = a_itm.slice(opts.items.oldVisible, nI).hide(),
						orgW = opts.items[opts.d['width']];
					opts.items[opts.d['width']] = 'variable';
				} else {
					var hiddenitems = false;
				}

				var i_siz = getTotalSize(a_itm.slice(0, nI), opts, 'width'),
					w_siz = mapWrapperSizes(getSizes(c_new, opts, true), opts, !opts.usePadding);

				if (hiddenitems) {
					opts.items[opts.d['width']] = orgW;
				}
				if (opts.usePadding) {
					resetMargin(l_old, opts, opts.padding[opts.d[1]]);
					resetMargin(l_new, opts, opts.padding[opts.d[1]]);
				}
				if (opts.align) {
					opts.padding[opts.d[1]] = p[1];
					opts.padding[opts.d[3]] = p[0];
				}

				var a_cfs = {},
					a_old = {},
					a_cur = {},
					a_dur = sO.duration;

					 if (sO.fx == 'none')	a_dur = 0;
				else if (a_dur == 'auto')	a_dur = opts.scroll.duration / opts.scroll.items * nI;
				else if (a_dur <= 0)		a_dur = 0;
				else if (a_dur < 10)		a_dur = i_siz / a_dur;

				var a_conf = {
					duration: a_dur,
					easing	: sO.easing
				};
				if (sO.onBefore) sO.onBefore.call($tt0, c_old, c_new, w_siz, a_dur);
				if (opts.usePadding) {
					a_old[opts.d['marginRight']] = l_old.data('cfs_origCssMargin');
					a_cur[opts.d['marginRight']] = l_cur.data('cfs_origCssMargin') + opts.padding[opts.d[3]];
					l_new.css(opts.d['marginRight'], l_new.data('cfs_origCssMargin') + opts.padding[opts.d[1]]);
					l_old.stop().animate(a_old, a_conf);
					l_cur.stop().animate(a_cur, a_conf);
				}
				a_cfs[opts.d['left']] = -i_siz;

				if (opts[opts.d['width']] == 'variable' || opts[opts.d['height']] == 'variable') {
					$wrp.stop().animate(w_siz, a_conf);
				}

				//	alternative effects
				switch(sO.fx) {
					case 'crossfade':
					case 'cover':
					case 'uncover':
						var $cf2 = $cfs.clone().appendTo($wrp);
						break;
				}
				switch(sO.fx) {
					case 'crossfade':
					case 'cover':
						getItems($cf2).slice(0, nI).remove();
						getItems($cf2).slice(opts.items.visible).remove();
						break;
					case 'uncover':
						getItems($cf2).slice(opts.items.oldVisible).remove();
						break;
				}
				switch(sO.fx) {
					case 'fade':
						fx_fade(sO, $cfs, 0, a_dur);
						break;
					case 'crossfade':
						$cf2.css({ opacity: 0 });
						fx_fade(sO, $cf2, 1, a_dur);
						fx_fade(sO, $cfs, 1, a_dur, function() { $cf2.remove(); });
						break;
					case 'cover':
						fx_cover(sO, $cfs, $cf2, opts, a_dur, false);
						break;
					case 'uncover':
						fx_uncover(sO, $cfs, $cf2, opts, a_dur, false, nI);
						break;
				}

				switch(sO.fx) {
					case 'fade':
					case 'crossfade':
					case 'cover':
					case 'uncover':
						f_dur = a_dur;
						a_dur = 0;
						break;
				}
				//	/alternative effects

				var c_nI = nI;
				$cfs.animate(a_cfs, {
					duration: a_dur,
					easing	: sO.easing,
					complete: function() {
						var overFill = opts.items.visible+c_nI-totalItems,
							new_m = (opts.usePadding) ? opts.padding[opts.d[3]] : 0;
						$cfs.css(opts.d['left'], new_m);
						if (overFill > 0) {
							getItems($cfs).slice(totalItems).remove();
						}
						var l_itm = getItems($cfs).slice(0, c_nI).appendTo($cfs).last();
						if (overFill > 0) {
							c_new = getCurrentItems(getItems($cfs), opts);
						}
						if (hiddenitems) hiddenitems.show();
						if (opts.usePadding) {
							if (totalItems < opts.items.visible+c_nI) {
								var l_cur = getItems($cfs).eq(opts.items.visible-1);
								l_cur.css(opts.d['marginRight'], l_cur.data('cfs_origCssMargin') + opts.padding[opts.d[3]]);
							}
							l_itm.css(opts.d['marginRight'], l_itm.data('cfs_origCssMargin'));
						}

						var fn = function() {
							if (sO.onAfter) {
								sO.onAfter.call($tt0, c_old, c_new, w_siz);
							}
							if (queue.length) {
								setTimeout(function() {
									$cfs.trigger(queue[0][0], queue[0][1]);
									queue.shift();
								}, 1);
							}
						};
						switch(sO.fx) {
							case 'fade':
							case 'uncover':
								fx_fade(sO, $cfs, 1, f_dur, fn);
								break;

							default:
								fn();
								break;
						}
					}
				});
				$cfs.trigger('updatePageStatus', [false, w_siz]).trigger('play', a_dur);
			});

			$cfs.bind('slideTo.cfs'+serial, function(e, num, dev, org, obj, dir) {
				e.stopPropagation();

				var v = [num, dev, org, obj, dir],
					t = ['string/number/object', 'number', 'boolean', 'object', 'string'],
					a = sortParams(v, t);
				
				var obj = a[3],
					dir = a[4];

				num = getItemIndex(a[0], a[1], a[2], firstItem, totalItems, $cfs);

				if (num == 0) return;
				if (typeof obj != 'object') obj = false;

				if ($cfs.is(':animated') && obj.duration > 0) return;

				if (dir != 'prev' && dir != 'next') {
					if (opts.circular) {
						if (num <= totalItems / 2) 	dir = 'next';
						else 						dir = 'prev';
					} else {
						if (firstItem == 0 ||
							firstItem > num)		dir = 'next';
						else						dir = 'prev';
					}
				}

				if (dir == 'prev')	$cfs.trigger('prev', [obj, totalItems-num]);
				else 				$cfs.trigger('next', [obj, num]);
			});
			
			$cfs.bind('jumpToStart.cfs'+serial, function(e) {
				if (firstItem > 0) {
					$cfs.prepend(getItems($cfs).slice(firstItem));
				}
			});

			$cfs.bind('synchronise.cfs'+serial, function(e, s) {
					 if (s) 				s = getSynchArr(s);
				else if (opts.synchronise)	s = opts.synchronise;
				else return debug(opts.debug, 'No carousel to synchronise.');

				var n = $cfs.triggerHandler('currentPosition');
				for (var j = 0, l = s.length; j < l; j++) {
					s[j][0].trigger('slideTo', [n, s[j][3], true]);
				}
			});

			$cfs.bind('queue.cfs'+serial, function(e, dir, opt) {
				if (typeof dir == 'undefined') {
					return queue;
				} else if (typeof dir == 'function') {
					dir.call($tt0, queue);
				} else if (is_array(dir)) {
					queue = dir;
				} else {
					queue.push([dir, opt]);
				}
			});

			$cfs.bind('insertItem.cfs'+serial, function(e, itm, num, org, dev) {
				e.stopPropagation();

				var v = [itm, num, org, dev],
					t = ['string/object', 'string/number/object', 'boolean', 'number'],
					a = sortParams(v, t);
				
				var itm = a[0],
					num = a[1],
					org = a[2],
					dev = a[3];

				if (typeof itm == 'object' && 
					typeof itm.jquery == 'undefined')	itm = $(itm);
				if (typeof itm == 'string') 			itm = $(itm);
				if (typeof itm != 'object' ||
					typeof itm.jquery == 'undefined' || 
					itm.length == 0) return debug(opts.debug, 'Not a valid object.');

				if (typeof num == 'undefined') num = 'end';

				if (opts.usePadding) {
					itm.each(function() {
						var m = parseInt($(this).css(opts.d['marginRight']));
						if (isNaN(m)) m = 0;
						$(this).data('cfs_origCssMargin', m);
					});
				}

				var orgNum = num,
					before = 'before';

				if (num == 'end') {
					if (org) {
						if (firstItem == 0) {
							num = totalItems-1;
							before = 'after';
						} else {
							num = firstItem;
							firstItem += itm.length
						}
						if (num < 0) num = 0;
					} else {
						num = totalItems-1;
						before = 'after';
					}
				} else {
					num = getItemIndex(num, dev, org, firstItem, totalItems, $cfs);
				}
				if (orgNum != 'end' && !org) {
					if (num < firstItem) firstItem += itm.length;
				}
				if (firstItem >= totalItems) firstItem -= totalItems;

				var $cit = getItems($cfs).eq(num);
				if ($cit.length) {
					$cit[before](itm);
				} else {
					$cfs.append(itm);
				}

				totalItems = getItems($cfs).length;
				$cfs.trigger('linkAnchors');
				var sz = setSizes($cfs, opts);
				showNavi(opts, totalItems);
				enableNavi(opts, firstItem);
				$cfs.trigger('updatePageStatus', [true, sz]);
			});

			$cfs.bind('removeItem.cfs'+serial, function(e, num, org, dev) {
				e.stopPropagation();
				
				var v = [num, org, dev],
					t = ['string/number/object', 'boolean', 'number'],
					a = sortParams(v, t);
				
				var num = a[0],
					org = a[1],
					dev = a[2];

				if (typeof num == 'undefined' || num == 'end') {
					getItems($cfs).last().remove();
				} else {
					num = getItemIndex(num, dev, org, firstItem, totalItems, $cfs);
					var $cit = getItems($cfs).eq(num);
					if ($cit.length){
						if (num < firstItem) firstItem -= $cit.length;
						$cit.remove();
					}
				}
				totalItems = getItems($cfs).length;
				var sz = setSizes($cfs, opts);
				showNavi(opts, totalItems);
				enableNavi(opts, firstItem);
				$cfs.trigger('updatePageStatus', [true, sz]);
			});

			$cfs.bind('currentPosition.cfs'+serial, function(e, fn) {
				e.stopPropagation();
				if (firstItem == 0) var val = 0;
				else var val = totalItems - firstItem;
				if (typeof fn == 'function') fn.call($tt0, val);
				return val;
			});

			$cfs.bind('currentPage.cfs'+serial, function(e, fn) {
				e.stopPropagation();
				var max = Math.ceil(totalItems/opts.items.visible-1);
				if (firstItem == 0) var nr = 0;
				else if (firstItem < totalItems % opts.items.visible) var nr = 0;
				else if (firstItem == opts.items.visible && !opts.circular) var nr = max;
				else var nr = Math.round((totalItems-firstItem)/opts.items.visible);
				if (nr < 0) nr = 0;
				if (nr > max) nr = max;
				if (typeof fn == 'function') fn.call($tt0, nr);
				return nr;
			});

			$cfs.bind('currentVisible.cfs'+serial, function(e, fn) {
				e.stopPropagation();
				$i = getCurrentItems(getItems($cfs), opts);
				if (typeof fn == 'function') fn.call($tt0, $i);
				return $i;
			});

			$cfs.bind('isPaused.cfs'+serial, function(e, fn) {
				e.stopPropagation();
				if (typeof fn == 'function') fn.call($tt0, isPaused);
				return isPaused;
			});

			$cfs.bind('configuration.cfs'+serial, function(e, a, b, c) {
				e.stopPropagation();
				var reInit = false;

				//	return entire configuration-object
				if (typeof a == 'function') {
					a.call($tt0, opts);

				//	set multiple options via object
				} else if (typeof a == 'object') {
					opts_orig = $.extend(true, {}, opts_orig, a);
					if (b !== false) reInit = true;
					else opts = $.extend(true, {}, opts, a);

				} else if (typeof a != 'undefined') {

					//	callback function for specific option
					if (typeof b == 'function') {
						var val = eval('opts.'+a);
						if (typeof val == 'undefined') val = '';
						b.call($tt0, val);

					//	set individual option
					} else if (typeof b != 'undefined') {
						if (typeof c !== 'boolean') c = true;
						if ($cfs.is(':animated')) {
							setTimeout(function() {
								$cfs.trigger('configuration', [a, b, c]);
							}, 100);
							return debug(opts.debug, 'carousel animated, configuration timeout.');
						}
						eval('opts_orig.'+a+' = b');
						if (c !== false) reInit = true;
						else eval('opts.'+a+' = b');

					//	return value for specific option
					} else {
						return eval('opts.'+a);
					}
				}
				if (reInit) {
					resetMargin(getItems($cfs), opts);
					$cfs.init(opts_orig);
					setSizes($cfs, opts);
				}
				return opts;
			});

			$cfs.bind('linkAnchors.cfs'+serial, function(e, $con, sel) {
				e.stopPropagation();
				if (typeof $con == 'undefined' || $con.length == 0) $con = $('body');
				else if (typeof $con == 'string') $con = $($con);
				if (typeof $con != 'object') return debug(opts.debug, 'Not a valid object.');
				if (typeof sel != 'string' || sel.length == 0) sel = 'a.caroufredsel';
				$con.find(sel).each(function() {
					var h = this.hash || '';
					if (h.length > 0 && getItems($cfs).index($(h)) != -1) {
						$(this).unbind('click').click(function(e) {
							e.preventDefault();
							$cfs.trigger('slideTo', h);
						});
					}
				});
			});

			$cfs.bind('updatePageStatus.cfs'+serial, function(e, build, sizes) {
				e.stopPropagation();
				if (!opts.pagination.container) return;
				if (typeof build == 'boolean' && build) {
					getItems(opts.pagination.container).remove();
					for (var a = 0, l = Math.ceil(totalItems/opts.items.visible); a < l; a++) {
						var i = getItems($cfs).eq( getItemIndex(a*opts.items.visible, 0, true, firstItem, totalItems, $cfs) );
						opts.pagination.container.append(opts.pagination.anchorBuilder(a+1, i));
					}
					getItems(opts.pagination.container).unbind('click').each(function(a) {
						$(this).click(function(e) {
							e.preventDefault();
							$cfs.trigger('slideTo', [a * opts.items.visible, 0, true, opts.pagination]);
						});
					});
				}
				$cfs.trigger('currentPage', function(nr) {
					getItems(opts.pagination.container).removeClass('selected').eq(nr).addClass('selected');
				});
			});

			$cfs.bind('destroy.cfs'+serial, function(e, orgOrder) {
				e.stopPropagation();
				if (orgOrder) {
					$cfs.trigger('jumpToStart');
				}
				if (opts.usePadding) {
					resetMargin(getItems($cfs), opts);
				}
				$cfs.trigger('pause').css($cfs.data('cfs_origCss'));
				$cfs.unbind_events();
				$cfs.unbind_buttons();
				$wrp.replaceWith($cfs);
			});



			//	DEPRECATED
			$cfs.bind('slidePrev.cfs'+serial, function(e, sO, nI) {
				e.stopPropagation();
				debug(true, 'The custom event "slidePrev" is deprecated, use "slide_prev".');
				$cfs.trigger('slide_prev', [sO, nI]);
			});
			$cfs.bind('slideNext.cfs'+serial, function(e, sO, nI) {
				e.stopPropagation();
				debug(true, 'The custom event "slideNext" is deprecated, use "slide_next".');
				$cfs.trigger('slide_next', [sO, nI]);
			});
			//	/DEPRECATED



		};	//	/bind_events

		$cfs.unbind_events = function() {
			$cfs.unbind('.cfs'+serial);
		};	//	/unbind_events

		$cfs.bind_buttons = function() {
			$cfs.unbind_buttons();
			showNavi(opts, totalItems);
			enableNavi(opts, firstItem);
			if (opts.auto.pauseOnHover) {
				$wrp.bind('mouseenter.cfs'+serial, function() { $cfs.trigger('pause'); });
				$wrp.bind('mouseleave.cfs'+serial, function() { $cfs.trigger('play');	});
			}
			if (opts.prev.button) {
				opts.prev.button.bind('click.cfs'+serial, function(e) {
					e.preventDefault();
					$cfs.trigger('prev');
				});
				if (opts.prev.pauseOnHover) {
					opts.prev.button.bind('mouseenter.cfs'+serial, function() { $cfs.trigger('pause'); });
					opts.prev.button.bind('mouseleave.cfs'+serial, function() { $cfs.trigger('play');	});
				}
			}

			if (opts.next.button) {
				opts.next.button.bind('click.cfs'+serial, function(e) {
					e.preventDefault();
					$cfs.trigger('next');
				});
				if (opts.next.pauseOnHover) {
					opts.next.button.bind('mouseenter.cfs'+serial, function() { $cfs.trigger('pause'); });
					opts.next.button.bind('mouseleave.cfs'+serial, function() { $cfs.trigger('play');	});
				}
			}
			if ($.fn.mousewheel) {
				if (opts.prev.mousewheel) {
					$wrp.mousewheel(function(e, delta) { 
						if (delta > 0) {
							e.preventDefault();
							num = (typeof opts.prev.mousewheel == 'number') ? opts.prev.mousewheel : '';
							$cfs.trigger('prev', num);
						}
					});
				}
				if (opts.next.mousewheel) {
					$wrp.mousewheel(function(e, delta) { 
						if (delta < 0) {
							e.preventDefault();
							num = (typeof opts.next.mousewheel == 'number') ? opts.next.mousewheel : '';
							$cfs.trigger('next', num);
						}
					});
				}
			}
			if (opts.pagination.container) {
				if (opts.pagination.pauseOnHover) {
					opts.pagination.container.bind('mouseenter.cfs'+serial, function() { $cfs.trigger('pause'); });
					opts.pagination.container.bind('mouseleave.cfs'+serial, function() { $cfs.trigger('play');	});
				}
			}
			if (opts.next.key || opts.prev.key) {
				$(document).bind('keyup.cfs'+serial, function(e) {
					var k = e.keyCode;
					if (k == opts.next.key)	{
						e.preventDefault();
						$cfs.trigger('next');
					}
					if (k == opts.prev.key) {
						e.preventDefault();
						$cfs.trigger('prev');
					}
				});
			}
			if (opts.pagination.keys) {
				$(document).bind('keyup.cfs'+serial, function(e) {
					var k = e.keyCode;
					if (k >= 49 && k < 58) {
						k = (k-49) * opts.items.visible;
						if (k <= totalItems) {
							e.preventDefault();
							$cfs.trigger('slideTo', [k, 0, true, opts.pagination]);
						}
					}
				});
			}
			if (opts.auto.play) {
				$cfs.trigger('play', opts.auto.delay);
				if ($.fn.nap && opts.auto.nap) {
					$cfs.nap('pause', 'play');
				}
			}
		};	//	/bind_buttons

		$cfs.unbind_buttons = function() {
			$(document).unbind('.cfs'+serial);
			$wrp.unbind('.cfs'+serial);
			if (opts.prev.button) 			opts.prev.button.unbind('.cfs'+serial);
			if (opts.next.button) 			opts.next.button.unbind('.cfs'+serial);
			if (opts.pagination.container)	opts.pagination.container.unbind('.cfs'+serial);
			showNavi(opts, 'hide');
			enableNavi(opts, 'removeClass');
			if (opts.pagination.container) {
				getItems(opts.pagination.container).remove();
			}
		};	//	/unbind_buttons




		//	DEPRECATED
		$cfs.configuration = function(a, b) {
			debug(true, 'The "configuration" public method is deprecated, use the "configuration" custom event.');
			var cr = false;
			var fn = function(val) { cr = val; };
			if (!a) a = fn;
			if (!b) b = fn;
			$cfs.trigger('configuration', [a, b]);
			return cr;
		};
		$cfs.current_position = function() {
			debug(true, 'The "current_position" public method is deprecated, use the "currentPosition" custom event.');
			var cp = false;
			$cfs.trigger('currentPosition', function(val) { cp = val; });
			return cp;
		};
		$cfs.destroy = function() {
			debug(true, 'The "destroy" public method is deprecated, use the "destroy" custom event.');
			$cfs.trigger('destroy');
			return $cfs;
		};
		$cfs.link_anchors = function($c, se) {
			debug(true, 'The "link_anchors" public method is deprecated, use the "linkAnchors" custom event.');
			$cfs.trigger('linkAnchors', [$c, se]);
			return $cfs;
		};
		//	/DEPRECATED




		if ($cfs.parent().is('.caroufredsel_wrapper')) {
			var strt = $cfs.triggerHandler( 'currentPosition' );
			$cfs.trigger('destroy', true);
		} else {
			var strt = false;
		}
		
		var $wrp 			= $cfs.wrap('<div class="caroufredsel_wrapper" />').parent(),
			opts 			= {},
			opts_orig		= o,
			totalItems		= getItems($cfs).length,
			firstItem 		= 0,
			autoTimeout		= null,
			autoInterval	= null,
			timerInterval	= null,
			pauseTimePassed	= 0,
			isPaused		= true,
			direction		= 'next',
			queue			= [],
			serial 			= $.fn.carouFredSel.serial++;

		$cfs.init(opts_orig, true, strt);
		$cfs.build();
		$cfs.bind_events();
		$cfs.bind_buttons();

		if (opts.items.start != 0) {
			var s = opts.items.start;
			if (s === true) {
				s = window.location.hash;
				if (!s.length) s = 0;
			} else if (s === 'random') {
				s = Math.floor(Math.random() * totalItems);
			}

			$cfs.trigger('slideTo', [s, 0, true, { duration: 0 }, 'next']);
		}
		var siz = setSizes($cfs, opts, false),
			itm = getCurrentItems(getItems($cfs), opts);

		if (opts.onCreate) {
			opts.onCreate.call($tt0, itm, siz);
		}

		$cfs.trigger('updatePageStatus', [true, siz]);
		$cfs.trigger('linkAnchors');
		return this;
	};


	//	public
	$.fn.carouFredSel.serial = 0;
	$.fn.carouFredSel.defaults = {
		debug: false,
		synchronise: false,
		infinite: true,
		circular: true,
		direction: 'left',
		items: {
			start: 0
		},
		scroll: {
			easing: 'swing',
			pauseOnHover: false,
			mousewheel: false,
			queue: false
		}
	};

	$.fn.carouFredSel.pageAnchorBuilder = function(nr, itm) {
		return '<a href="#"><span>'+nr+'</span></a>';
	};


	//	private
	function fx_fade(sO, c, x, d, f) {
		var o = {
			duration: d,
			easing: sO.easing
		};
		if (typeof f == 'function') o.complete = f;
		c.animate({
			opacity: x
		}, o);
	}
	function fx_cover(sO, c1, c2, o, d, prev) {
		var old_w = getSizes(getOldItemsNext(getItems(c1), o), o, true)[0],
			new_w = getSizes(getItems(c2), o, true)[0],
			cur_l = (prev) ? -new_w : old_w,
			css_o = {},
			ani_o = {};
		css_o[o.d['width']] = new_w;
		css_o[o.d['left']] = cur_l;
		ani_o[o.d['left']] = 0;
		c1.animate({ opacity: '+=0' }, d);
		c2.css(css_o).animate(ani_o, {
			duration: d,
			easing: sO.easing,
			complete: function() {
				$(this).remove();
			}
		});
	}
	function fx_uncover(sO, c1, c2, o, d, prev, n) {
		var new_w = getSizes(getNewItemsNext(getItems(c1), o, n), o, true)[0],
			old_w = getSizes(getItems(c2), o, true)[0],
			cur_l = (prev) ? -old_w : new_w,
			css_o = {},
			ani_o = {};

		css_o[o.d['width']] = old_w;
		css_o[o.d['left']] = 0;
		ani_o[o.d['left']] = cur_l;
		c2.css(css_o).animate(ani_o, {
			duration: d,
			easing: sO.easing,
			complete: function() {
				$(this).remove();
			}
		});
	}

	function showNavi(o, t) {
		if (t == 'show' || t == 'hide') {
			var f = t;
		} else if (o.items.minimum >= t) {
			debug(o.debug, 'Not enough items: not scrolling');
			var f = 'hide';
		} else {
			var f = 'show';
		}
		if (o.prev.button) o.prev.button[f]();
		if (o.next.button) o.next.button[f]();
		if (o.pagination.container) o.pagination.container[f]();
	}
	function enableNavi(o, f) {
		if (o.circular || o.infinite) return;
		var fx = (f == 'removeClass' || f == 'addClass') ? f : false;
		if (o.next.button) {
			var fn = fx || (f == o.items.visible) ? 'addClass' : 'removeClass';
			o.next.button[fn]('disabled');
		}
		if (o.prev.button) {
			var fn = fx || (f == 0) ? 'addClass' : 'removeClass';
			o.prev.button[fn]('disabled');
		}
	}
	function sortParams(vals, typs) {
		var _arr = [];
		for (var a = 0, l1 = vals.length; a < l1; a++) {
			for (var b = 0, l2 = typs.length; b < l2; b++) {
				if (typs[b].indexOf(typeof vals[a]) > -1 && !_arr[b]) {
					_arr[b] = vals[a];
					break;
				}
			}
		}
		return _arr;
	}
	function getSynchArr(s) {
		if (!is_array(s)) 		s = [[s]];
		if (!is_array(s[0]))	s = [s];
		for (var j = 0, l = s.length; j < l; j++) {
			if (typeof s[j][0] == 'string')		s[j][0] = $(s[j][0]);
			if (typeof s[j][1] != 'boolean')	s[j][1] = true;
			if (typeof s[j][2] != 'boolean')	s[j][2] = true;
			if (typeof s[j][3] != 'number')		s[j][3] = 0;
		}
		return s;
	}
	function getKeyCode(k) {
		if (k == 'right')	return 39;
		if (k == 'left')	return 37;
		if (k == 'up')		return 38;
		if (k == 'down')	return 40;
		return -1;
	}
	function getObject($tt, obj) {
		if (typeof obj == 'function')	obj = obj.call($tt);
		if (typeof obj == 'undefined')	obj = {};
		return obj;
	}
	function getNaviObject($tt, obj, pagi, auto) {
		if (typeof pagi != 'boolean') pagi = false;
		if (typeof auto != 'boolean') auto = false;

		obj = getObject($tt, obj);
		if (typeof obj == 'string') {
			var temp = getKeyCode(obj);
			if (temp == -1) obj = $(obj);
			else 			obj = temp;
		}

		//	pagination
		if (pagi) {
			if (typeof obj 				== 'boolean')	obj = { keys: obj };
			if (typeof obj.jquery 		!= 'undefined')	obj = { container: obj };
			if (typeof obj.container	== 'function')	obj.container = obj.container.call($tt);
			if (typeof obj.container	== 'string')	obj.container = $(obj.container);
			if (typeof obj.event		!= 'string')	obj.event = 'click';

		//	auto
		} else if (auto) {
			if (typeof obj == 'boolean')				obj = { play: obj };
			if (typeof obj == 'number')					obj = { pauseDuration: obj };

		//	prev + next
		} else {
			if (typeof obj.jquery	!= 'undefined')		obj = { button: obj };
			if (typeof obj 			== 'number')		obj = { key: obj };
			if (typeof obj.button	== 'function')		obj.button = obj.button.call($tt);
			if (typeof obj.button	== 'string')		obj.button = $(obj.button);
			if (typeof obj.key		== 'string')		obj.key = getKeyCode(obj.key);
			if (typeof obj.event	!= 'string')		obj.event = 'click';
		}
		return obj;
	}
	function getItemIndex(num, dev, org, firstItem, totalItems, $cfs) {
		if (typeof num == 'string') {
			if (isNaN(num)) num = $(num);
			else 			num = parseInt(num);
		}
		if (typeof num == 'object') {
			if (typeof num.jquery == 'undefined') num = $(num);
			num = getItems($cfs).index(num);
			if (num == -1) num = 0;
			if (typeof org != 'boolean') org = false;
		} else {
			if (typeof org != 'boolean') org = true;
		}
		if (isNaN(num))	num = 0;
		else 			num = parseInt(num);
		if (isNaN(dev))	dev = 0;
		else 			dev = parseInt(dev);

		if (org) {
			num += firstItem;
		}
		num += dev;
		if (totalItems > 0) {
			while (num >= totalItems)	{	num -= totalItems; }
			while (num < 0)				{	num += totalItems; }
		}
		return num;
	}

	function getItems(c, f) {
		var $i = $('> *', c);
		if (typeof f == 'string') $i = $i.filter(f);
		return $i;
	}
	function getCurrentItems(i, o) {
		return i.slice(0, o.items.visible);
	}
	function getOldItemsPrev(i, o, n) {
		return i.slice(n, o.items.oldVisible+n);
	}
	function getNewItemsPrev(i, o) {
		return i.slice(0, o.items.visible);
	}
	function getOldItemsNext(i, o) {
		return i.slice(0, o.items.oldVisible);
	}
	function getNewItemsNext(i, o, n) {
		return i.slice(n, o.items.visible+n);
	}

	function resetMargin(i, o, m) {
		var x = (typeof m == 'boolean') ? m : false;
		if (typeof m != 'number') m = 0;
		i.each(function() {
			var t = parseInt($(this).css(o.d['marginRight']));
			if (isNaN(t)) t = 0;
			$(this).data('cfs_tempCssMargin', t);
			$(this).css(o.d['marginRight'], ((x) ? $(this).data('cfs_tempCssMargin') : m + $(this).data('cfs_origCssMargin')));
		});
	}
	function getSizes(i, o, wrapper) {
		s1 = getTotalSize(i, o, 'width', wrapper);
		s2 = getLargestSize(i, o, 'height', wrapper);
		return [s1, s2];
	}
	function getLargestSize(i, o, dim, wrapper) {
		if (typeof wrapper != 'boolean') wrapper = false;
		if (typeof o[o.d[dim]] == 'number' && wrapper) return o[o.d[dim]];
		if (typeof o.items[o.d[dim]] == 'number') return o.items[o.d[dim]];
		var di2 = (dim.toLowerCase().indexOf('width') > -1) ? 'outerWidth' : 'outerHeight';
		return getTrueLargestSize(i, o, di2);
	}
	function getTrueLargestSize(i, o, dim) {
		var s = 0;
		i.each(function() {
			var m = $(this)[o.d[dim]](true);
			if (s < m) s = m;
		});
		return s;
	}
	function getTrueInnerSize($el, o, dim) {
		var siz = $el[o.d[dim]](),
			arr = (o.d[dim].toLowerCase().indexOf('width') > -1) ? ['paddingLeft', 'paddingRight'] : ['paddingTop', 'paddingBottom'];
		for (a = 0, l = arr.length; a < l; a++) {
			var m = parseInt($el.css(arr[a]));
			if (isNaN(m)) m = 0;
			siz -= m;
		}
		return siz;
	}
	function getTotalSize(i, o, dim, wrapper) {
		if (typeof wrapper != 'boolean') wrapper = false;
		if (typeof o[o.d[dim]] == 'number' && wrapper) return o[o.d[dim]];
		if (typeof o.items[o.d[dim]] == 'number') return o.items[o.d[dim]] * i.length;
		var di2 = (dim.toLowerCase().indexOf('width') > -1) ? 'outerWidth' : 'outerHeight';
		return getTotalSizeVariable(i, o, di2);
	}
	function getTotalSizeVariable(i, o, dim) {
		var s = 0;
		i.each(function() {
			var j = $(this);
if (j.is(':visible')) {
			s += j[o.d[dim]](true);
}
		});
		return s;
	}

	function hasVariableSizes(i, o, dim) {
		var s = false,
			v = false;
		i.each(function() { 
			c = $(this)[o.d[dim]](true);
			if (s === false) s = c;
			else if (s != c) v = true;
		});
		return v;
	}

	function mapWrapperSizes(ws, o, p) {
		if (typeof p != 'boolean') p = true;
		var pad = (o.usePadding && p) ? o.padding : [0, 0, 0, 0];
		var wra = {};
			wra[o.d['width']] = ws[0] + pad[1] + pad[3];
			wra[o.d['height']] = ws[1] + pad[0] + pad[2];

		return wra;
	}
	function setSizes($c, o, p) {
		var $w = $c.parent(),
			$i = getItems($c),
			$v = getCurrentItems($i, o),
			sz = mapWrapperSizes(getSizes($v, o, true), o, p);

		$w.css(sz);

		if (o.usePadding) {
			var $l = $v.last();
			$l.css(o.d['marginRight'], $l.data('cfs_origCssMargin') + o.padding[o.d[1]]);
			$c.css(o.d['top'], o.padding[o.d[0]]);
			$c.css(o.d['left'], o.padding[o.d[3]]);
		}
		$c.css(o.d['width'], getTotalSize($i, o, 'width')*2);
		$c.css(o.d['height'], getLargestSize($i, o, 'height'));
		return sz;
	}

	function getPadding(p) {
		if (typeof p == 'undefined') return [0, 0, 0, 0];
		
		if (typeof p == 'number') return [p, p, p, p];
		else if (typeof p == 'string') p = p.split('px').join('').split(' ');

		if (!is_array(p)) {
			return [0, 0, 0, 0];
		}
		for (var i = 0; i < 4; i++) {
			p[i] = parseInt(p[i]);
		}
		switch (p.length) {
			case 0: return [0, 0, 0, 0];
			case 1: return [p[0], p[0], p[0], p[0]];
			case 2: return [p[0], p[1], p[0], p[1]];
			case 3: return [p[0], p[1], p[2], p[1]];
			default: return [p[0], p[1], p[2], p[3]];
		}
	}
	function getAlignPadding(itm, o) {
		var x = (typeof o[o.d['width']] == 'number') ? Math.ceil(o[o.d['width']] - getTotalSize(itm, o, 'width')) : 0;
		switch (o.align) {
			case 'left':
				return [0, x];
				break;
			case 'right':
				return [x, 0];
				break;
			case 'center':
			default:
				var x1 = Math.ceil(x/2), x2 = Math.floor(x/2);
				return [x1, x2];
				break;
		}
	}

	function getVisibleItemsPrev(items, o, nI) {
		var total = 0,
			start = o.items.visible - nI - 1,
			x = 0;

		if (start < 0) start = items.length-1;
		for (var a = start; a >= 0; a--) {
			total += items.eq(a)[o.d['outerWidth']](true);
			if (total > o.maxDimention) return getVisibleItemsAdjust(x, o);
			if (a == 0) a = items.length;
			x++;
		}
	}
	function getVisibleItemsNext(items, o, nI) {
		var total = 0,
			x = 0;

		for (var a = nI, l = items.length-1; a <= l; a++) {
			total += items.eq(a)[o.d['outerWidth']](true);
			if (total > o.maxDimention) return getVisibleItemsAdjust(x, o);
			if (a == items.length-1) a = -1;
			x++;
		}
	}
	function getVisibleItemsAdjust(x, o) {
		switch (o.visibleAdjust) {
			case '+1':
				return x + 1;
				break;
			case '-1':
				return x - 1;
				break;
			case 'odd':
				if (x % 2 == 0) return x - 1;
				break;
			case 'odd+':
				if (x % 2 == 0) return x + 1;
				break;
			case 'even':
				if (x % 2 == 1) return x - 1;
				break;
			case 'even+':
				if (x % 2 == 1) return x + 1;
				break;
			default:
				return x;
				break;
		}
	}

	function is_array(a) {
		return typeof(a) == 'object' && (a instanceof Array);
	}

	function debug(d, m) {
		if (!d) return false;
		if (typeof m == 'string') m = 'carouFredSel: ' + m;
		else m = ['carouFredSel:', m];

		if (window.console && window.console.log) window.console.log(m);
		return false;
	}



	$.fn.caroufredsel = function(o) {
		return this.carouFredSel(o);
	};

})(jQuery);